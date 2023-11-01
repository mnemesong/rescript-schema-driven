open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenField
open Belt

type attr = Attr(string, schemaDrivenModule)

let printStruct = (props: array<field>): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  o->S.field("${propName}", ${propT->moduleName}.struct)`
  })
  `S.object(o => (
${propRows->Js.Array2.joinWith(",\n")}
))`
}

let printType = (props: array<field>): string => {
  let propRows = props->Array.map(p => {
    let Field(_, propT) = p
    `  ${propT->moduleName}.t`
  })
  `(
${propRows->Js.Array2.joinWith(",\n")}
)`
}

let makeResultCode = (moduleName: string, types: array<schemaDrivenModule>): resultCodeDeclar =>
  Array.mapWithIndex(types, (i, m) => Field("t_" ++ i->Int.toString, m))->(
    p => make(moduleName, printType(p), printStruct(p))
  )
