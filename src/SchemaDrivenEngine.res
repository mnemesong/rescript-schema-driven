open SchemaDrivenPlugin
open Belt

type schemaDrivenEngine

let def: (string, array<schemaDrivenPlugin>) => schemaDrivenEngine = %raw(`
function (path, plugins) {
  return {
    path: path,
    plugins: plugins
  };
}
`)

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

let cleanDirectory = (eng: schemaDrivenEngine): result<unit, exn> => {
  let clean: string => unit = %raw(`
  function (directory) {
    const fs = require("fs");
    const path = require("path");
    fs.readdir(directory, (err, files) => {
      if (err) throw err;
      for (const file of files) {
        fs.unlink(path.join(directory, file), (err) => {
          if (err) throw err;
        });
      }
    });
  }
  `)
  ResultExn.tryExec(() => clean(eng->path))
}

let printModule = (eng: schemaDrivenEngine, moduleName: string, code: string): result<
  SchemaDrivenModule.schemaDrivenModule,
  exn,
> => {
  let resolvePath: array<string> => string = %raw(`
  function(parts) {
    return require("path").resolve(...parts);
  }
  `)
  let writeFileSync: (string, string) => unit = %raw(`
  function (file, data) {
    return require("fs").writeFileSync(file, data);
  }
  `)
  let moduleName' = SchemaDrivenNamesCorrector.modifyModuleName(moduleName)
  let moduleFilePath = ResultExn.tryExec(() => resolvePath([eng->path, moduleName' ++ ".res"]))
  let code' = code ++ eng->plugins->Array.map(p => p.moduleBody)->Js.Array2.joinWith("\n\n")
  let result =
    moduleFilePath->ResultExn.flatMap(p => ResultExn.tryExec(() => writeFileSync(p, code')))
  ResultExn.map(result, _ => moduleName'->SchemaDrivenModule.def)
}
