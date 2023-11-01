open SchemaDrivenModule
open SchemaDrivenResultCode
open Belt

type objectProp = ObjectProp(string, schemaDrivenModule)

let printStruct = (props: array<objectProp>): string => {
  let propRows = props->Array.map(p => {
    let ObjectProp(propName, propT) = p
    `  ${propName}: o->S.field("${propName}", ${propT->moduleName}.struct)`
  })
  `S.object(o => {
${propRows->Js.Array2.joinWith(",\n")}
})`
}

let printType = (props: array<objectProp>): string => {
  let propRows = props->Array.map(p => {
    let ObjectProp(propName, propT) = p
    `  ${propName}:  ${propT->moduleName}.t`
  })
  `{
${propRows->Js.Array2.joinWith(",\n")}
}`
}

let makeResultCode = (moduleName: string, props: array<objectProp>): resultCodeDeclar =>
  make(moduleName, printType(props), printStruct(props))
