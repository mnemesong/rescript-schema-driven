open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy
open SchemaDrivenResultCode

type schemaDrivenEngine

let def: (
  string,
  array<schemaDrivenPlugin>,
  unexpectedFilesStrategy,
) => result<schemaDrivenEngine, exn>

let path: schemaDrivenEngine => string

let plugins: schemaDrivenEngine => array<schemaDrivenPlugin>

let isRemoveOnMatch: schemaDrivenEngine => bool

let printModule: (
  schemaDrivenEngine,
  string,
  resultCodeDeclar,
) => result<SchemaDrivenModule.schemaDrivenModule, exn>
