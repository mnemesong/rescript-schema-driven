open Belt
open! SchemaDriven

let _genDir: string = %raw(`require("path").resolve(module.path, "..", "..", "..", "_generated")`)

let eng =
  defEngine(
    _genDir,
    [SchemaDrivenRescriptStructPlugin.plugin],
    RemoveAllFilesFromDir,
  )->Belt.Result.getExn

let testOptionInt = optionNull("TestOptionInt", int, eng)->Result.getExn
let testOptionStr = optionNull("TestOptionStr", string, eng)->Result.getExn

let testPersonRec =
  record(
    "Test-Person",
    [Field("id", int), Field("ages", testOptionInt), Field("name", string)],
    eng,
  )->Result.getExn

let testProfileObj =
  object(
    "Test Profile",
    [Field("person", testPersonRec), Field("descr", testOptionStr)],
    eng,
  )->Result.getExn

let testTupleObject = tupleObject("TestTupleObject", [int, testOptionStr, bool], eng)->Result.getExn

let testVariantObject =
  variantObject(
    "TestVariantObject",
    [
      Field("circle", [Field("radius", float)]),
      Field("square", [Field("width", float), Field("height", float)]),
    ],
    eng,
  )->Result.getExn

let testVariantContainer =
  variantContainer(
    "TestVariantContainer",
    [Field("var1", [float]), Field("var2", [testOptionStr, float]), Field("var3", [string])],
    eng,
  )->Result.getExn

let testVariantLiteral =
  variantLiteral("TestVariantLiteral", ["Banana", "Orange", "Apple"], eng)->Result.getExn

let testTupleN = tupleN("TestTupleN", [string, testPersonRec, testOptionInt], eng)->Result.getExn

let testArray = array("TestArray", string, eng)->Result.getExn

let testList = list("TestList", float, eng)->Result.getExn
