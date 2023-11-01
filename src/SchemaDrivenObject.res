open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenField
open Belt

let printStruct = (props: array<field>): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  "${propName}": o->S.field("${propName}", ${propT->moduleName}.struct)`
  })
  `S.object(o => {
${propRows->Js.Array2.joinWith(",\n")}
})`
}

let printType = (props: array<field>): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  "${propName}":  ${propT->moduleName}.t`
  })
  `{
${propRows->Js.Array2.joinWith(",\n")}
}`
}

let makeResultCode = (moduleName: string, props: array<field>): resultCodeDeclar =>
  make(moduleName, printType(props), printStruct(props))
