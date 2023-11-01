open Belt

type resultCodeDeclar = {
  moduleName: string,
  t: string,
  struct: string,
  moduleTypes: array<string>,
  funcDeclars: array<string>,
}

let make = (moduleName: string, t: string, struct: string): resultCodeDeclar => {
  moduleName,
  t,
  struct,
  moduleTypes: ["SchemaDrivenModule"],
  funcDeclars: [],
}

let addModuleType = (resultCodeDeclar: resultCodeDeclar, moduleType: string): resultCodeDeclar => {
  ...resultCodeDeclar,
  moduleTypes: resultCodeDeclar.moduleTypes->Array.concat([moduleType]),
}

let addFuncs = (resultCodeDeclar: resultCodeDeclar, funcs: array<string>): resultCodeDeclar => {
  ...resultCodeDeclar,
  funcDeclars: funcs->Array.reduce(resultCodeDeclar.funcDeclars, (acc, f) => {
    Js.Array2.includes(acc, f) ? acc : acc->Array.concat([f])
  }),
}

let printModuleBody = (resultCodeDeclar: resultCodeDeclar): string =>
  [
    "type t = " ++ resultCodeDeclar.t,
    "let struct: S.t<" ++ resultCodeDeclar.t ++ "> = " ++ resultCodeDeclar.struct,
  ]
  ->Array.concat(resultCodeDeclar.funcDeclars)
  ->Js.Array2.joinWith("\n\n")
