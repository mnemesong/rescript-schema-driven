type testVariantContainer = 
  | Var1(SchemaDrivenFloat.t)
  | Var2(TestOptionStr.t, SchemaDrivenFloat.t)
  | Var3(SchemaDrivenString.t)

type t = testVariantContainer

let struct: S.t<t> = S.union([
  S.object(o => {
    ignore(o->S.field("TAG", S.literal(String("Var1"))))
    Var1(
      o->S.field("t_0", SchemaDrivenFloat.struct)
    )
  })->S.Object.strip,
  S.object(o => {
    ignore(o->S.field("TAG", S.literal(String("Var2"))))
    Var2(
      o->S.field("t_0", TestOptionStr.struct),
      o->S.field("t_1", SchemaDrivenFloat.struct)
    )
  })->S.Object.strip,
  S.object(o => {
    ignore(o->S.field("TAG", S.literal(String("Var3"))))
    Var3(
      o->S.field("t_0", SchemaDrivenString.struct)
    )
  })->S.Object.strip
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