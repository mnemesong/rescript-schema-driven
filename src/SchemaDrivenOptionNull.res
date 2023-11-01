open SchemaDrivenModule
open SchemaDrivenResultCode

let printStruct = (m: schemaDrivenModule): string => `S.null(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `option<${m->moduleName}.t>`

let def = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
): result<schemaDrivenModule, exn> => {
  let resultCode = make(moduleName, printType(t), printStruct(t))
  SchemaDrivenEngine.printModule(engine, moduleName, resultCode)
}
