type resultCodeDeclar = {
  moduleName: string,
  t: string,
  struct: string,
  moduleTypes: array<string>,
  funcDeclars: array<string>,
}

let make: (string, string, string) => resultCodeDeclar

let addModuleType: (resultCodeDeclar, string) => resultCodeDeclar

let filterModuleTypes: (resultCodeDeclar, string => bool) => resultCodeDeclar

let addFuncs: (resultCodeDeclar, array<string>) => resultCodeDeclar

let printModuleBody: resultCodeDeclar => string

let printModuleType: resultCodeDeclar => string
