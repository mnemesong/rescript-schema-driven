open SchemaDrivenModule
open SchemaDrivenResultCode

let printStruct = (m: schemaDrivenModule): string => `S.list(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `list<${m->moduleName}.t>`

let makeResultCode = (moduleName: string, t: schemaDrivenModule): resultCodeDeclar =>
  make(moduleName, printType(t), printStruct(t))
