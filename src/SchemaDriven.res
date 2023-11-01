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

type field<'a> = SchemaDrivenField.field<'a>

let record = (
  moduleName: string,
  props: array<field<schemaDrivenModule>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenRecord.makeResultCode(moduleName, props) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )

let object = (
  moduleName: string,
  props: array<field<schemaDrivenModule>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenObject.makeResultCode(moduleName, props) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )

let tupleObject = (
  moduleName: string,
  types: array<schemaDrivenModule>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenTupleObject.makeResultCode(moduleName, types) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )

let variantObject = (
  moduleName: string,
  variants: array<field<array<field<schemaDrivenModule>>>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenVariantObject.makeResultCode(moduleName, variants) |> SchemaDrivenEngine.printModule(
    engine,
    moduleName,
  )

let variantContainer = (
  moduleName: string,
  variants: array<field<array<schemaDrivenModule>>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenVariantContainer.makeResultCode(
    moduleName,
    variants,
  ) |> SchemaDrivenEngine.printModule(engine, moduleName)
