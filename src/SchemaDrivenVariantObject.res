open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper
open SchemaDrivenNamesCorrector
open Belt

let printStruct = (
  variants: array<variant<array<field<schemaDrivenModule>>>>,
  tagName: string,
  strict: bool,
): string => {
  let strictAnnot = strict ? "->S.Object.strict" : "->S.Object.strip"
  let variantRows = variants->Array.map(v => {
    let Variant(varName, props) = v
    let varName' = modifyVariantName(varName)
    let propRows = Array.map(props, p => {
      let Field(propName, t) = p
      `      ${propName}: o->S.field("${propName}", ${t->moduleName}.struct)`
    })
    `  S.object(o => {
    ignore(o->S.field("${tagName}", S.literal(String("${varName'}"))))
    ${varName'}({\n${propRows->Js.Array2.joinWith(",\n")}\n    })
  })${strictAnnot}`
  })
  `S.union([
${variantRows->Js.Array2.joinWith(",\n")}
])`
}

let printType = (variants: array<variant<array<field<schemaDrivenModule>>>>): string => {
  let variantRows = variants->Array.map(v => {
    let Variant(varName, props) = v
    let propRows = Array.map(props, p => {
      let Field(propName, t) = p
      `      ${propName}: ${t->moduleName}.t`
    })
    `  | ${varName->modifyVariantName}({\n${propRows->Js.Array2.joinWith(",\n")}
    })`
  })
  "\n" ++ variantRows->Js.Array2.joinWith("\n")
}

let allVariantsFunc = (variants: array<variant<array<field<schemaDrivenModule>>>>): string => {
  let allNames = variants->Array.map(v => {
    let Variant(name, _) = v
    name
  })
  `let allVariants = ` ++ Js.Json.stringifyAny(allNames)->Option.getExn
}

let makeResultCode = (
  moduleName: string,
  variants: array<variant<array<field<schemaDrivenModule>>>>,
  tagName: string,
  strict: bool,
): resultCodeDeclar =>
  make(moduleName, printType(variants), printStruct(variants, tagName, strict))
  ->addFuncs([allVariantsFunc(variants)])
  ->addModuleType("SchemaDrivenModule.SchemaDrivenVariantModule")
