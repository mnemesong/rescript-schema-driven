open SchemaDrivenModule
open SchemaDrivenResultCode

let printStruct = (m: schemaDrivenModule): string => `S.dict(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `Js.Dict.t<${m->moduleName}.t>`

let makeResultCode = (moduleName: string, t: schemaDrivenModule): resultCodeDeclar =>
  make(moduleName, printType(t), printStruct(t))
