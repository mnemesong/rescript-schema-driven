type testVariantObject = 
  | Circle({
      radius: SchemaDrivenFloat.t
    })
  | Square({
      width: SchemaDrivenFloat.t,
      height: SchemaDrivenFloat.t
    })

type t = testVariantObject

let struct: S.t<t> = S.union([
  S.object(o => {
    ignore(o->S.field("TAG", S.literal(String("Circle"))))
    Circle({
      radius: o->S.field("radius", SchemaDrivenFloat.struct)
    })
  })->S.Object.strip,
  S.object(o => {
    ignore(o->S.field("TAG", S.literal(String("Square"))))
    Square({
      width: o->S.field("width", SchemaDrivenFloat.struct),
      height: o->S.field("height", SchemaDrivenFloat.struct)
    })
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