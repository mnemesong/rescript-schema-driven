open SchemaDrivenModule
open SchemaDrivenResultCode

let printStruct = (m: schemaDrivenModule): string => `S.array(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `array<${m->moduleName}.t>`

let makeResultCode = (moduleName: string, t: schemaDrivenModule): resultCodeDeclar =>
  make(moduleName, printType(t), printStruct(t))
