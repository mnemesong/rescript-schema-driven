open SchemaDrivenPlugin
open SchemaDrivenResultCode
open SchemaDrivenNamesCorrector

let prefixPlugin: string => schemaDrivenPlugin = (
  prefix: string,
  resultCodeDeclar: resultCodeDeclar,
) => resultCodeDeclar->editModuleName(n => modifyModuleName(prefix) ++ n)

let postfixPlugin: string => schemaDrivenPlugin = (
  prefix: string,
  resultCodeDeclar: resultCodeDeclar,
) => resultCodeDeclar->editModuleName(n => n ++ modifyModuleName(prefix))
