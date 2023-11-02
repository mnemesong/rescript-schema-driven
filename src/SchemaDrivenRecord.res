open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper
open Belt

let printStruct = (props: array<field<schemaDrivenModule>>, strict: bool): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  ${propName}: o->S.field("${propName}", ${propT->moduleName}.struct)`
  })
  let strictAnnot = strict ? "->S.Object.strict" : "->S.Object.strip"
  `S.object(o => {
${propRows->Js.Array2.joinWith(",\n")}
})${strictAnnot}`
}

let printType = (props: array<field<schemaDrivenModule>>): string => {
  let propRows = props->Array.map(p => {
    let Field(propName, propT) = p
    `  ${propName}:  ${propT->moduleName}.t`
  })
  `{
${propRows->Js.Array2.joinWith(",\n")}
}`
}

let makeResultCode = (
  moduleName: string,
  props: array<field<schemaDrivenModule>>,
  strict: bool,
): resultCodeDeclar => make(moduleName, printType(props), printStruct(props, strict))
