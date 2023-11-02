open SchemaDrivenPlugin

exception RescriptStructExn(S.Error.t)

let structErrToExn: result<'t, S.Error.t> => result<'t, exn>

let thenStructErrToExn: promise<result<'t, S.Error.t>> => promise<result<'t, exn>>

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

let rescriptStructParse: string

let rescriptStructParseAny: string

let rescriptStructParseJson: string

let rescriptStructParseAsync: string

let rescriptStructSerialize: string

let rescriptStructSerializeToUnknown: string

let rescriptStructSerializeToJson: string

let plugin: schemaDrivenPlugin
