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
let testOptionStr = optionNull("TestOptionStr", string, eng)->Result.getExn
let testPerson =
  record(
    "Test-Person",
    [Field("id", int), Field("ages", testOptionInt), Field("name", string)],
    eng,
  )->Result.getExn
let testProfile =
  object(
    "Test Profile",
    [Field("person", testPerson), Field("descr", testOptionStr)],
    eng,
  )->Result.getExn
