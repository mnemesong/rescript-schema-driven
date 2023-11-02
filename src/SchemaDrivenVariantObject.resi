open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper

let printStruct: (array<variant<array<field<schemaDrivenModule>>>>, string, bool) => string

let printType: array<variant<array<field<schemaDrivenModule>>>> => string

let makeResultCode: (
  string,
  array<variant<array<field<schemaDrivenModule>>>>,
  string,
  bool,
) => resultCodeDeclar
