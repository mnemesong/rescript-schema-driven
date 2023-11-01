open SchemaDrivenPlugin
open SchemaDrivenResultCode

exception RescriptStructExn(S.Error.t)

let structErrToExn = (res: result<'t, S.Error.t>): result<'t, exn> =>
  switch res {
  | Ok(t) => Ok(t)
  | Error(e) => Error(RescriptStructExn(e))
  }

let thenStructErrtoExn = async (res: promise<result<'t, S.Error.t>>): result<'t, exn> =>
  (await res)->structErrToExn

module type ModuleType = {
  type t

  let parse: Js.Json.t => result<t, exn>
  let parseAny: 'a => result<t, exn>
  let parseJsonString: string => result<t, exn>
  let parseAsync: Js.Json.t => promise<result<'value, exn>>
}

let rescriptStructParse = `let parse = (x) => x->S.parseWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseAny = `let parseAny = (x) => x->S.parseAnyWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseJsonString = `let parseJsonString = (x) => x->S.parseJsonStringWith(struct)
->SchemaDrivenRescriptStructPlugin.structErrToExn`

let rescriptStructParseAsync = `let parseAsync = (x) => x->S.parseAsyncWith(struct)
->SchemaDrivenRescriptStructPlugin.thenStructErrToExn`

let plugin: schemaDrivenPlugin = (resultCodeDeclar: resultCodeDeclar) =>
  resultCodeDeclar
  ->addFuncs([
    rescriptStructParse,
    rescriptStructParseAny,
    rescriptStructParseJsonString,
    rescriptStructParseAsync,
  ])
  ->addModuleType(
    `SchemaDrivenRescriptStructPlugin.ModuleType with type t = ` ++ resultCodeDeclar.t,
  )
