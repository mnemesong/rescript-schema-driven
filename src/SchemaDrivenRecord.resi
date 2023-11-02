open SchemaDrivenModule
open SchemaDrivenResultCode
open SchemaDrivenHelper

let printStruct: (array<field<schemaDrivenModule>>, bool) => string

let printType: array<field<schemaDrivenModule>> => string

let makeResultCode: (string, array<field<schemaDrivenModule>>, bool) => resultCodeDeclar
