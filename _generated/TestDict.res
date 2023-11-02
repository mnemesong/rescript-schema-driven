type testDict = Js.Dict.t<TestOptionStr.t>

type t = testDict

let struct: S.t<t> = S.dict(TestOptionStr.struct)

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