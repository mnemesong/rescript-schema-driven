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

type field = SchemaDrivenField.field

let record = (
  moduleName: string,
  props: array<field>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenRecord.makeResultCode(moduleName, props) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )

let object = (
  moduleName: string,
  props: array<field>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenObject.makeResultCode(moduleName, props) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )
