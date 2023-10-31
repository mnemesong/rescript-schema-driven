let unallowedCharFilterFunc = (c: string, i: int): bool => {
  let firstSymbolRegEx = %re("/[a-zA-Z_]/")
  let otherSymbolsRegEx = %re("/[a-zA-Z0-9_]/")
  i == 0 ? firstSymbolRegEx->Js.Re.test_(c) : otherSymbolsRegEx->Js.Re.test_(c)
}

let modifyVariableName = (varName: string): string =>
  varName
  ->Js.String2.split("")
  ->Js.Array2.filteri(unallowedCharFilterFunc)
  ->Js.Array2.mapi((c, i) => i == 0 ? Js.String.toLowerCase(c) : c)
  ->Js.Array2.joinWith("")

let modifyVariantName = (varName: string): string =>
  varName
  ->Js.String2.split("")
  ->Js.Array2.filteri(unallowedCharFilterFunc)
  ->Js.Array2.mapi((c, i) => i == 0 ? Js.String.toUpperCase(c) : c)
  ->Js.Array2.joinWith("")

let modifyModuleName = modifyVariantName

let modifyPolymorficVariantName = (varName: string): string =>
  varName->Js.String2.split("")->Js.Array2.filteri(unallowedCharFilterFunc)->Js.Array2.joinWith("")
