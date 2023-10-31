open SchemaDrivenModule

let printStruct = (m: schemaDrivenModule): string => `S.option(${m->moduleName}.struct)`

let printType = (m: schemaDrivenModule): string => `option<${m->moduleName}.t>`

let def = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
): result<schemaDrivenModule, exn> => {
  let structCode = printStruct(t)
  let typeCode = printType(t)
  let code =
    [`type t = ${typeCode}`, `let struct: S.t<${typeCode}> = ${structCode}`]->Js.Array2.joinWith(
      "\n\n",
    )
  SchemaDrivenEngine.printModule(engine, moduleName, code)
}
