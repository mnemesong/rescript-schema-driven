open SchemaDrivenModule

let defEngine = SchemaDrivenEngine.def

let int = def("SchemaDrivenInt")

let float = def("SchemaDrivenFloat")

let string = def("SchemaDrivenString")

let bool = def("SchemaDrivenBool")

let optionNull = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenOptionNull.makeResultCode(moduleName, t) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )
