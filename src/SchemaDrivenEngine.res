open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy
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

let printModule = (eng: schemaDrivenEngine, moduleName: string, code: string): result<
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
  let code' = code ++ eng->plugins->Array.map(p => p.moduleBody)->Js.Array2.joinWith("\n\n")
  let result =
    moduleFilePath->ResultExn.flatMap(p =>
      ResultExn.tryExec(() => writeFileSync(p, code', isRemoveOnMatch(eng)))
    )
  ResultExn.map(result, _ => moduleName'->SchemaDrivenModule.def)
}
