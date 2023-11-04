open SchemaDrivenPlugin
open SchemaDrivenResultCode
open SchemaDrivenNamesCorrector

let prefixPlugin: string => schemaDrivenPlugin = (
  prefix: string,
  resultCodeDeclar: resultCodeDeclar,
) =>
  resultCodeDeclar
  ->editModuleName(n => modifyModuleName(prefix) ++ n)
  ->editModuleTypes(t =>
    Js.String2.replace(
      t,
      "type t = " ++ resultCodeDeclar.moduleName->modifyVariableName,
      "type t = " ++ (modifyModuleName(prefix) ++ resultCodeDeclar.moduleName)->modifyVariableName,
    )
  )

let postfixPlugin: string => schemaDrivenPlugin = (
  postfix: string,
  resultCodeDeclar: resultCodeDeclar,
) =>
  resultCodeDeclar
  ->editModuleName(n => n ++ modifyModuleName(postfix))
  ->editModuleTypes(t =>
    Js.String2.replace(
      t,
      "type t = " ++ resultCodeDeclar.moduleName->modifyVariableName,
      "type t = " ++ (resultCodeDeclar.moduleName ++ modifyModuleName(postfix))->modifyVariableName,
    )
  )
