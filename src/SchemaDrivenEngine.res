open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy
open SchemaDrivenResultCode
open Belt

type schemaDrivenEngine

let def = (
  dir: string,
  plugins: array<schemaDrivenPlugin>,
  unexpectedFilesStrategy: unexpectedFilesStrategy,
): result<schemaDrivenEngine, exn> => {
  let initScheme: (string, array<schemaDrivenPlugin>, bool) => schemaDrivenEngine = %raw(`
  function (path, plugins, removeOnMatch) {
    return {
      path: path,
      plugins: plugins,
      removeOnMatch: removeOnMatch
    };
  }
  `)
  let result = switch unexpectedFilesStrategy {
  | RemoveAllFilesFromDir => cleanDirectory(dir)
  | _ => Ok()
  }
  Result.map(result, _ => initScheme(dir, plugins, removeOnMatch(unexpectedFilesStrategy)))
}

let path: schemaDrivenEngine => string = %raw(`
function (dir) {
  return dir.path;
}
`)

let plugins: schemaDrivenEngine => array<schemaDrivenPlugin> = %raw(`
function (dir) {
  return dir.plugins;
}
`)

let isRemoveOnMatch: schemaDrivenEngine => bool = %raw(`
function (dir) {
  return dir.removeOnMatch;
}
`)

let printModule = (eng: schemaDrivenEngine, moduleName: string, code: resultCodeDeclar): result<
  SchemaDrivenModule.schemaDrivenModule,
  exn,
> => {
  let resolvePath: array<string> => string = %raw(`
  function(parts) {
    return require("path").resolve(...parts);
  }
  `)
  let moduleName' = SchemaDrivenNamesCorrector.modifyModuleName(moduleName)
  let moduleFilePath = ResultExn.tryExec(() => resolvePath([eng->path, moduleName' ++ ".res"]))
  let moduleTypePath = ResultExn.tryExec(() => resolvePath([eng->path, moduleName' ++ ".resi"]))
  let resultCode = eng->plugins->Array.reduce(code, (acc, p) => p(acc))
  let moduleBody = resultCode->printModuleBody
  let moduleType = resultCode->printModuleType
  moduleFilePath
  ->ResultExn.flatMap(p =>
    ResultExn.tryExec(() => writeFileSync(p, moduleBody, isRemoveOnMatch(eng)))
  )
  ->Result.flatMap(_ =>
    moduleTypePath->Result.flatMap(p =>
      ResultExn.tryExec(() => writeFileSync(p, moduleType, isRemoveOnMatch(eng)))
    )
  )
  ->ResultExn.map(_ => moduleName'->SchemaDrivenModule.def)
}
