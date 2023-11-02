type crazyTaggedVariant = 
  | Fruit(TestVariantLiteral.t)
  | FruitSet(TestArray.t)

type t = crazyTaggedVariant

let struct: S.t<t> = S.union([
  S.object(o => {
    ignore(o->S.field("crazyTaggedVariant", S.literal(String("Fruit"))))
    Fruit(
      o->S.field("t_0", TestVariantLiteral.struct)
    )
  }),
  S.object(o => {
    ignore(o->S.field("crazyTaggedVariant", S.literal(String("FruitSet"))))
    FruitSet(
      o->S.field("t_0", TestArray.struct)
    )
  })
])

let parse = (x) => x->S.parseWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn

let parseAny = (x) => x->S.parseAnyWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn

let parseJson = (x) => x->S.parseJsonWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn

let parseAsync = (x) => x->S.parseAsyncWith(struct)
->SchemaDrivenRescriptStructPlugin.thenStructErrToExn

let serialize = (x) => x->S.serializeWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn

let serializeToUnknown = (x) => x->S.serializeToUnknownWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn

let serializeToJson = (x) => x->S.serializeToJsonWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn