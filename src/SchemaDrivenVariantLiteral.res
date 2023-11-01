open SchemaDrivenResultCode
open SchemaDrivenNamesCorrector
open Belt

let printStruct = (variants: array<string>): string => {
  let variantRows = variants->Array.map(v => {
    let v' = v->modifyVariantName
    `  S.literalVariant(String("${v'}"), ${v'})`
  })
  `S.union([
${variantRows->Js.Array2.joinWith(",\n")}
])`
}

let printType = (variants: array<string>): string => {
  let variantRows = variants->Array.map(v => "  | " ++ v->modifyVariantName)
  "\n" ++ variantRows->Js.Array2.joinWith("\n")
}

let makeResultCode = (moduleName: string, variants: array<string>): resultCodeDeclar =>
  make(moduleName, printType(variants), printStruct(variants))
