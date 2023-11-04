open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper
open SchemaDrivenNamesCorrector
open Belt

let printStruct = (
  variants: array<variant<array<schemaDrivenModule>>>,
  tagName: string,
  strict: bool,
): string => {
  let strictAnnot = strict ? "->S.Object.strict" : "->S.Object.strip"
  let variantRows = variants->Array.map(v => {
    let Variant(varName, types) = v
    let varName' = modifyVariantName(varName)
    let typeRows = Array.mapWithIndex(types, (i, t) => {
      let propName = "t_" ++ i->Int.toString
      `      o->S.field("${propName}", ${t->moduleName}.struct)`
    })
    let varParams =
      typeRows->Array.length > 0 ? `(\n${typeRows->Js.Array2.joinWith(",\n")}\n    )` : ""
    `  S.object(o => {
    ignore(o->S.field("${tagName}", S.literal(String("${varName'}"))))
    ${varName'}${varParams}
  })${strictAnnot}`
  })
  `S.union([
${variantRows->Js.Array2.joinWith(",\n")}
])`
}

let printType = (variants: array<variant<array<schemaDrivenModule>>>): string => {
  let variantRows = variants->Array.map(v => {
    let Variant(varName, types) = v
    let typeRows = Array.map(types, t => {
      t->moduleName ++ ".t"
    })
    let varParams = typeRows->Array.length > 0 ? `(${typeRows->Js.Array2.joinWith(", ")})` : ""
    `  | ${varName->modifyVariantName}` ++ varParams
  })
  "\n" ++ variantRows->Js.Array2.joinWith("\n")
}

let allVariantsFunc = (variants: array<variant<array<schemaDrivenModule>>>): string => {
  let allNames = variants->Array.map(v => {
    let Variant(name, _) = v
    name
  })
  `let allVariants = ` ++ Js.Json.stringifyAny(allNames)->Option.getExn
}

let makeResultCode = (
  moduleName: string,
  variants: array<variant<array<schemaDrivenModule>>>,
  tagName: string,
  strict: bool,
): resultCodeDeclar =>
  make(moduleName, printType(variants), printStruct(variants, tagName, strict))
  ->addFuncs([allVariantsFunc(variants)])
  ->addModuleType("SchemaDrivenModule.SchemaDrivenVariantModule")
