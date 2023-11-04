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
      Variant("circle", [Field("radius", float)]),
      Variant("square", [Field("width", float), Field("height", float)]),
    ],
    eng,
  )->Result.getExn

let testVariantContainer =
  variantContainer(
    "TestVariantContainer",
    [Variant("var1", [float]), Variant("var2", [testOptionStr, float]), Variant("var3", [string])],
    eng,
  )->Result.getExn

let testVariantLiteral =
  variantLiteral("TestVariantLiteral", ["Banana", "Orange", "Apple"], eng)->Result.getExn

let testTupleN = tupleN("TestTupleN", [string, testPersonRec, testOptionInt], eng)->Result.getExn

let testArray = array("TestArray", string, eng)->Result.getExn

let testList = list("TestList", float, eng)->Result.getExn

let testDict = dict("TestDict", testOptionStr, eng)->Result.getExn

let crazyTaggedVariant =
  variantContainer(
    "CrazyTaggedVariant",
    [Variant("Fruit", [testVariantLiteral]), Variant("FruitSet", [testArray])],
    eng,
    ~tagName="crazyTaggedVariant",
    ~strict=true,
  )->Result.getExn

let publish =
  publishModules(
    "Publish",
    [
      testOptionInt,
      testOptionStr,
      testPersonRec,
      testProfileObj,
      testVariantObject,
      testVariantContainer,
      testVariantLiteral,
      testTupleN,
      testArray,
      testList,
      testDict,
      crazyTaggedVariant,
    ],
    eng,
  )->Result.getExn

let eng2 =
  defEngine(
    _genDir,
    [SchemaDrivenModifyModuleNamePlugin.prefixPlugin("Pre")],
    RemoveOnlyInMatch,
  )->Belt.Result.getExn

let optionBool = optionNull("OptionBool", bool, eng2)->Result.getExn
