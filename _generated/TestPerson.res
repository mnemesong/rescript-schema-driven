type testPerson = {
  id:  SchemaDrivenInt.t,
  ages:  TestOptionInt.t,
  name:  SchemaDrivenString.t
}

type t = testPerson

let struct: S.t<t> = S.object(o => {
  id: o->S.field("id", SchemaDrivenInt.struct),
  ages: o->S.field("ages", TestOptionInt.struct),
  name: o->S.field("name", SchemaDrivenString.struct)
})->S.Object.strip

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