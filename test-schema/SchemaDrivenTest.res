open SchemaDriven
open Belt

let _genDir: string = %raw(`require("path").resolve(module.path, "..", "..", "..", "_generated")`)

let eng =
  defEngine(
    _genDir,
    [SchemaDrivenRescriptStructPlugin.plugin],
    RemoveAllFilesFromDir,
  )->Belt.Result.getExn

let testOptionInt = optionNull("TestOptionInt", int, eng)->Result.getExn
let testPerson =
  record(
    "Test-Person",
    [ObjectProp("id", int), ObjectProp("ages", testOptionInt), ObjectProp("name", string)],
    eng,
  )->Result.getExn
