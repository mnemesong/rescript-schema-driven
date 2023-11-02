open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenField
open SchemaDrivenNamesCorrector
open Belt

let printStruct = (variants: array<field<array<schemaDrivenModule>>>, tagName: string): string => {
  let variantRows = variants->Array.map(v => {
    let Field(varName, types) = v
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
  })`
  })
  `S.union([
${variantRows->Js.Array2.joinWith(",\n")}
])`
}

let printType = (variants: array<field<array<schemaDrivenModule>>>): string => {
  let variantRows = variants->Array.map(v => {
    let Field(varName, types) = v
    let typeRows = Array.map(types, t => {
      t->moduleName ++ ".t"
    })
    let varParams = typeRows->Array.length > 0 ? `(${typeRows->Js.Array2.joinWith(", ")})` : ""
    `  | ${varName->modifyVariantName}` ++ varParams
  })
  "\n" ++ variantRows->Js.Array2.joinWith("\n")
}

let makeResultCode = (
  moduleName: string,
  variants: array<field<array<schemaDrivenModule>>>,
  tagName: string,
): resultCodeDeclar => make(moduleName, printType(variants), printStruct(variants, tagName))
