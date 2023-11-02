type testTupleObject = (
  SchemaDrivenInt.t,
  TestOptionStr.t,
  SchemaDrivenBool.t
)

type t = testTupleObject

let struct: S.t<t> = S.object(o => (
  o->S.field("t_0", SchemaDrivenInt.struct),
  o->S.field("t_1", TestOptionStr.struct),
  o->S.field("t_2", SchemaDrivenBool.struct)
))->S.Object.strip

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