type preOptionBool = option<SchemaDrivenBool.t>

type t = preOptionBool

let struct: S.t<t> = S.null(SchemaDrivenBool.struct)