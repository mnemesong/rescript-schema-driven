open SchemaDrivenModule
open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy

type field<'a> = SchemaDrivenHelper.field<'a>
type variant<'a> = SchemaDrivenHelper.variant<'a>

let defEngine: (
  string,
  array<schemaDrivenPlugin>,
  unexpectedFilesStrategy,
) => result<SchemaDrivenEngine.schemaDrivenEngine, exn>

let publishModules: (
  string,
  array<schemaDrivenModule>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let int: schemaDrivenModule

let float: schemaDrivenModule

let string: schemaDrivenModule

let bool: schemaDrivenModule

let unknown: schemaDrivenModule

let optionNull: (
  string,
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let record: (
  ~strict: bool=?,
  string,
  array<field<schemaDrivenModule>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let object: (
  ~strict: bool=?,
  string,
  array<field<schemaDrivenModule>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let tupleN: (
  string,
  array<schemaDrivenModule>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let tupleObject: (
  ~strict: bool=?,
  string,
  array<schemaDrivenModule>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let variantObject: (
  ~tagName: string=?,
  ~strict: bool=?,
  string,
  array<variant<array<field<schemaDrivenModule>>>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let variantContainer: (
  ~tagName: string=?,
  ~strict: bool=?,
  string,
  array<variant<array<schemaDrivenModule>>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let variantLiteral: (
  string,
  array<string>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let array: (
  string,
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let list: (
  string,
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

let dict: (
  string,
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>
