open Belt
open SchemaDrivenNamesCorrector

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
  moduleTypes: [
    "SchemaDrivenModule.SchemaDrivenModule with type t = " ++ moduleName->modifyVariableName,
  ],
  funcDeclars: [],
}

let addModuleType = (resultCodeDeclar: resultCodeDeclar, moduleType: string): resultCodeDeclar => {
  ...resultCodeDeclar,
  moduleTypes: resultCodeDeclar.moduleTypes->Array.concat([moduleType]),
}

let filterModuleTypes = (
  resultCodeDeclar: resultCodeDeclar,
  filter: string => bool,
): resultCodeDeclar => {
  ...resultCodeDeclar,
  moduleTypes: resultCodeDeclar.moduleTypes->Js.Array2.filter(filter),
}

let addFuncs = (resultCodeDeclar: resultCodeDeclar, funcs: array<string>): resultCodeDeclar => {
  ...resultCodeDeclar,
  funcDeclars: funcs->Array.reduce(resultCodeDeclar.funcDeclars, (acc, f) => {
    Js.Array2.includes(acc, f) ? acc : acc->Array.concat([f])
  }),
}

let printModuleBody = (resultCodeDeclar: resultCodeDeclar): string =>
  [
    `type ${resultCodeDeclar.moduleName->modifyVariableName} = ${resultCodeDeclar.t}`,
    "type t = " ++ resultCodeDeclar.moduleName->modifyVariableName,
    "let struct: S.t<t> = " ++ resultCodeDeclar.struct,
  ]
  ->Array.concat(resultCodeDeclar.funcDeclars)
  ->Js.Array2.joinWith("\n\n")

let printModuleType = (resultCodeDeclar: resultCodeDeclar): string =>
  `type ${resultCodeDeclar.moduleName->modifyVariableName} = ${resultCodeDeclar.t}\n\n` ++
  resultCodeDeclar.moduleTypes->Array.map(t => "include " ++ t)->Js.Array2.joinWith("\n")
