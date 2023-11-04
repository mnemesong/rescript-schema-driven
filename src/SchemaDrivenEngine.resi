open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy
open SchemaDrivenResultCode
open SchemaDrivenModule

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
  resultCodeDeclar,
) => result<SchemaDrivenModule.schemaDrivenModule, exn>

let publish: (
  string,
  array<schemaDrivenModule>,
  schemaDrivenEngine,
) => result<schemaDrivenModule, exn>
