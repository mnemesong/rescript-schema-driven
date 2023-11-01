open SchemaDrivenModule
open SchemaDrivenResultCode
open Belt

let printStruct = (params: array<schemaDrivenModule>): string => {
  let paramRows = params->Array.map(p => {
    `  ${p->moduleName}.struct`
  })
  `S.Tuple.factory(. \n${paramRows->Js.Array2.joinWith(",\n")}\n)`
}

let printType = (params: array<schemaDrivenModule>): string => {
  let paramRows = params->Array.map(p => {
    `  ${p->moduleName}.t`
  })
  `(\n${paramRows->Js.Array2.joinWith(",\n")}\n)`
}

let makeResultCode = (moduleName: string, params: array<schemaDrivenModule>): resultCodeDeclar =>
  make(moduleName, printType(params), printStruct(params))
