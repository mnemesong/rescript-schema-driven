open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper
open Belt

let printStruct = (props: array<field<schemaDrivenModule>>, strict: bool): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  o->S.field("${propName}", ${propT->moduleName}.struct)`
  })
  let strictAnnot = strict ? "->S.Object.strict" : "->S.Object.strip"
  `S.object(o => (
${propRows->Js.Array2.joinWith(",\n")}
))${strictAnnot}`
}

let printType = (props: array<field<schemaDrivenModule>>): string => {
  let propRows = props->Array.map(p => {
    let Field(_, propT) = p
    `  ${propT->moduleName}.t`
  })
  `(
${propRows->Js.Array2.joinWith(",\n")}
)`
}

let makeResultCode = (
  moduleName: string,
  types: array<schemaDrivenModule>,
  strict: bool,
): resultCodeDeclar =>
  Array.mapWithIndex(types, (i, m) => Field("t_" ++ i->Int.toString, m))->(
    p => make(moduleName, printType(p), printStruct(p, strict))
  )
