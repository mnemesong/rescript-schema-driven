open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper

let printStruct: (array<variant<array<schemaDrivenModule>>>, string, bool) => string

let printType: array<variant<array<schemaDrivenModule>>> => string

let makeResultCode: (
  string,
  array<variant<array<schemaDrivenModule>>>,
  string,
  bool,
) => resultCodeDeclar
