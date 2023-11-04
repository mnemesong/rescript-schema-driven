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

let editModuleName: (resultCodeDeclar, string => string) => resultCodeDeclar

let editModuleTypes: (resultCodeDeclar, string => string) => resultCodeDeclar
