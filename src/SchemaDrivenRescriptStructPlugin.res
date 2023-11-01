open SchemaDrivenPlugin
open SchemaDrivenResultCode

exception RescriptStructExn(S.Error.t)

let structErrToExn = (res: result<'t, S.Error.t>): result<'t, exn> =>
  switch res {
  | Ok(t) => Ok(t)
  | Error(e) => Error(RescriptStructExn(e))
  }

let thenStructErrToExn = async (res: promise<result<'t, S.Error.t>>): result<'t, exn> =>
  (await res)->structErrToExn

module type ModuleType = {
  include SchemaDrivenModule.SchemaDrivenModule

  let parse: Js.Json.t => result<t, exn>
  let parseAny: 'a => result<t, exn>
  let parseJson: string => result<t, exn>
  let parseAsync: Js.Json.t => promise<result<t, exn>>
  let serialize: t => result<Js.Json.t, exn>
  let serializeToUnknown: t => result<unknown, exn>
  let serializeToJson: t => result<string, exn>
}

let rescriptStructParse = `let parse = (x) => x->S.parseWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseAny = `let parseAny = (x) => x->S.parseAnyWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseJson = `let parseJson = (x) => x->S.parseJsonWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseAsync = `let parseAsync = (x) => x->S.parseAsyncWith(struct)
->SchemaDrivenRescriptStructPlugin.thenStructErrToExn`

let rescriptStructSerialize = `let serialize = (x) => x->S.serializeWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructSerializeToUnknown =
  `let serializeToUnknown = ` ++ `(x) => x->S.serializeToUnknownWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructSerializeToJson =
  `let serializeToJson = ` ++ `(x) => x->S.serializeToJsonWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let plugin: schemaDrivenPlugin = (resultCodeDeclar: resultCodeDeclar) =>
  resultCodeDeclar
  ->addFuncs([
    rescriptStructParse,
    rescriptStructParseAny,
    rescriptStructParseJson,
    rescriptStructParseAsync,
    rescriptStructSerialize,
    rescriptStructSerializeToUnknown,
    rescriptStructSerializeToJson,
  ])
  ->filterModuleTypes(mt => !Js.String2.includes(mt, "SchemaDrivenModule.SchemaDrivenModule"))
  ->addModuleType(
    `SchemaDrivenRescriptStructPlugin.ModuleType with type t = ` ++ resultCodeDeclar.t,
  )
