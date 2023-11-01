open SchemaDrivenModule
open SchemaDrivenResultCode

let printStruct = (m: schemaDrivenModule): string => `S.null(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `option<${m->moduleName}.t>`

let makeResultCode = (moduleName: string, t: schemaDrivenModule): resultCodeDeclar =>
  make(moduleName, printType(t), printStruct(t))
