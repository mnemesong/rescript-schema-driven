open SchemaDrivenModule

type field<'a> = SchemaDrivenHelper.field<'a>
type variant<'a> = SchemaDrivenHelper.variant<'a>

let defEngine = SchemaDrivenEngine.def

let publishModules = SchemaDrivenEngine.publish

let int = def("SchemaDrivenInt")

let float = def("SchemaDrivenFloat")

let string = def("SchemaDrivenString")

let bool = def("SchemaDrivenBool")

let unknown = def("SchemaDrivenUnknown")

let optionNull = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) => SchemaDrivenOptionNull.makeResultCode(moduleName, t) |> SchemaDrivenEngine.printModule(engine)

let record = (
  ~strict=false,
  moduleName: string,
  props: array<field<schemaDrivenModule>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenRecord.makeResultCode(moduleName, props, strict) |> SchemaDrivenEngine.printModule(
    engine,
  )

let object = (
  ~strict=false,
  moduleName: string,
  props: array<field<schemaDrivenModule>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenObject.makeResultCode(moduleName, props, strict) |> SchemaDrivenEngine.printModule(
    engine,
  )

let tupleN = (
  moduleName: string,
  params: array<schemaDrivenModule>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) => SchemaDrivenTupleN.makeResultCode(moduleName, params) |> SchemaDrivenEngine.printModule(engine)

let tupleObject = (
  ~strict=false,
  moduleName: string,
  types: array<schemaDrivenModule>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenTupleObject.makeResultCode(
    moduleName,
    types,
    strict,
  ) |> SchemaDrivenEngine.printModule(engine)

let variantObject = (
  ~tagName="TAG",
  ~strict=false,
  moduleName: string,
  variants: array<variant<array<field<schemaDrivenModule>>>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenVariantObject.makeResultCode(
    moduleName,
    variants,
    tagName,
    strict,
  ) |> SchemaDrivenEngine.printModule(engine)

let variantContainer = (
  ~tagName="TAG",
  ~strict=false,
  moduleName: string,
  variants: array<variant<array<schemaDrivenModule>>>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenVariantContainer.makeResultCode(
    moduleName,
    variants,
    tagName,
    strict,
  ) |> SchemaDrivenEngine.printModule(engine)

let variantLiteral = (
  moduleName: string,
  variants: array<string>,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) =>
  SchemaDrivenVariantLiteral.makeResultCode(moduleName, variants) |> SchemaDrivenEngine.printModule(
    engine,
  )

let array = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) => SchemaDrivenArray.makeResultCode(moduleName, t) |> SchemaDrivenEngine.printModule(engine)

let list = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) => SchemaDrivenList.makeResultCode(moduleName, t) |> SchemaDrivenEngine.printModule(engine)

let dict = (
  moduleName: string,
  t: schemaDrivenModule,
  engine: SchemaDrivenEngine.schemaDrivenEngine,
) => SchemaDrivenDict.makeResultCode(moduleName, t) |> SchemaDrivenEngine.printModule(engine)
