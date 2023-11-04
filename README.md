# rescript-schema-driven
serializable type modules generation for rescript with rescript-struct


## Installation
```sh
npm install rescript-struct@4.*
npm install rescript-schema-driven
```

Note! package coded for rescript-struct v4!

Then add `rescript-struct` and `rescript-schema-driven` to `bs-dependencies` in your `bsconfig.json`:

```diff
{
  ...
+ "bs-dependencies": ["rescript-struct", "rescript-schema-driven"]
+ "bsc-flags": ["-open RescriptStruct"],
}
```


## Motivation
- Make your serializible types-schemas file, thats will one source-of-true.
- Have always correct and capable types-declarations and rescript-struct schemas, 
and safety refactoring, they are gives to you.
- Extends generated modules with plugins, adds to all modules new functionality you need.



## Example of usage
Create file with schemas declaration code
```rescript
open Belt
open! SchemaDriven

let _genDir: string = %raw(`require("path").resolve(module.path, "..", "..", "..", "_generated")`)

//Engine is code-generation runner information container which will be used 
//for generation every module
let eng =
  defEngine(
    _genDir, //target dir for generation files
    [SchemaDrivenRescriptStructPlugin.plugin], //plugins. 
    //Plugins add extra api for modules and may be used for exteding functionality
    //This plugin will add extra api:
    //let parse: Js.Json.t => result<t, exn>
    //let parseAny: 'a => result<t, exn>
    //let parseJson: string => result<t, exn>
    //let parseAsync: Js.Json.t => promise<result<t, exn>>
    //let serialize: t => result<Js.Json.t, exn>
    //let serializeToUnknown: t => result<unknown, exn>
    //let serializeToJson: t => result<string, exn>
    RemoveAllFilesFromDir, //pregeneration dir handling strategy
  )->Belt.Result.getExn

//Will generate module TestOptionInt with type option<int> and api for interaction with type
let testOptionInt = optionNull("TestOptionInt", int, eng)->Result.getExn

//Will generate module TestPerson with type
//{
//  id: int,
//  ages: option<int>
//  name: string
//} and api for interaction with type
let testPersonRec =
  record(
    "Test-Person", //Invalid module name, will automatically correct to TestPerson
    [Field("id", int), Field("ages", testOptionInt), Field("name", string)],
    eng,
  )->Result.getExn
```
and run it by node directly.

## API

#### SchemaDriven.resi
```rescript
open SchemaDrivenModule
open SchemaDrivenPlugin
open SchemaDrivenUnexpectedFilesStrategy

type field<'a> = SchemaDrivenHelper.field<'a>
type variant<'a> = SchemaDrivenHelper.variant<'a>

let defEngine: (
  string, //target dir path
  array<schemaDrivenPlugin>, //plugins
  unexpectedFilesStrategy, //use RemoveAllFilesFromDir by default, 
  //more details in SchemaDrivenUnexpectedFilesStrategy.resi
) => result<SchemaDrivenEngine.schemaDrivenEngine, exn>

//type schemaDrivenModule is container with wrapped info about existed module file, implements
//SchemaDrivenModule.SchemaDrivenModule module type.
//For primitive data types contains ref on pre-compiled module. For generic types 

let int: schemaDrivenModule //int type module ref

let float: schemaDrivenModule //float type module ref

let string: schemaDrivenModule //string type module ref

let bool: schemaDrivenModule //bool type module ref

let unknown: schemaDrivenModule //unknown type module ref

//module generator for option type, wich will serizlize to value or null
let optionNull: (
  string, //module name
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for record type which will serialize to js-object (js-structure)
let record: (
  ~strict: bool=?,
  string, //module name
  array<field<schemaDrivenModule>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for object type which will serialize to js-object (js-structure)
let object: (
  ~strict: bool=?,
  string, //module name
  array<field<schemaDrivenModule>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for tuple type, wich will serialized to array [t1', t2', ...]
//Power of tuple defined by num of type in param
let tupleN: (
  string, //module name
  array<schemaDrivenModule>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for tuple, which will serialize to structure {t_0: t0', t_1: t1', ...}
let tupleObject: (
  ~strict: bool=?,
  string, //module name
  array<schemaDrivenModule>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for variant of object, which contains variant tag in one of it's properties
let variantObject: (
  ~tagName: string=?, //name of tag-contans property
  ~strict: bool=?,
  string, //module name
  array<variant<array<field<schemaDrivenModule>>>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>
//for example declaration:
//variantObject(
//  "TestVariantObject",
//  [
//    Variant("circle", [Field("radius", float)]),
//    Variant("square", [Field("width", float), Field("height", float)]),
//  ],
//  eng,
//)
//
//will compiled to module with type 
//type testVariantObject = 
//  | Circle({
//      radius: SchemaDrivenFloat.t
//    })
//  | Square({
//      width: SchemaDrivenFloat.t,
//      height: SchemaDrivenFloat.t
//    })
//
//witch serializing to structure:
//%raw(`{TAG: "Square", width: 15.2, height: 10}`)->parse == Square({width: 15.2, height: 10.0})


//module generator for variant of oany types, which contains variant tag and constructor params
//as prroperies of object
let variantContainer: (
  ~tagName: string=?,
  ~strict: bool=?,
  string, //module name
  array<variant<array<schemaDrivenModule>>>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>
//for example declaration:
//let testVariantContainer =
//  variantContainer(
//    "TestVariantContainer",
//    [Variant("var1", [float]), Variant("var2", [testOptionStr, float]), Variant("var3", [string])],
//    eng,
//  )
//
//will compiled to module with type 
//type testVariantContainer = 
//  | Var1(SchemaDrivenFloat.t)
//  | Var2(TestOptionStr.t, SchemaDrivenFloat.t)
//  | Var3(SchemaDrivenString.t)
//
//witch serializing to structure:
//%raw(`{TAG: "Var2", t_0: null, t_1: -1}`)->parse == Var2(None, -1.0)

//Variant of parameterless constructors wich will serizlized to same strings
let variantLiteral: (
  string, //module name
  array<string>,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for array type
let array: (
  string, //module name
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for list type
let list: (
  string, //module name
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>

//module generator for Js.Dict.t type
let dict: (
  string, //module name
  schemaDrivenModule,
  SchemaDrivenEngine.schemaDrivenEngine,
) => result<schemaDrivenModule, exn>
```

#### More examples of usage
Look more examples in this package: 
- declaration of example generated files in ./test-schema directory
- generated example files in ./_generated directory
- tests for then in ./_generated-test directory


## Publishing
You can get the `schemeDrivenModule` after executing any of the functions that generate module code. 
However, there may be a need to access generated modules from another package to generate 
new modules based on them.In this case, there is a high probability that when you try 
to access the name of the generated module, you will restart generation and get bugs.


To avoid this, I recommend following a few simple rules:
- Place your module in which generation is called in the dev folder, publishing only the generation result.
- To publish links to generated modules of type schemeDrivenModule, use the publishModules function.


The publishModules function generates another file in the target folder in which the specified 
schemeDrivenModules will be available as data, without the risk of triggering side effects when accessed.

```rescript
//Example
let eng =
  defEngine(...)->Belt.Result.getExn

let testOptionInt = optionNull("TestOptionInt", int, eng)->Result.getExn
let testOptionStr = optionNull("TestOptionStr", string, eng)->Result.getExn

...

//Will create Publish module with type aliaces to testOptionInt and testOptionStr,
let publish =
  publishModules(
    "Publish",
    [
      testOptionInt,
      testOptionStr,
      ...
    ],
    eng,
  )->Result.getExn

//--------------------------------------
//Publish.res
open SchemaDrivenModule

let testOptionInt: schemaDrivenModule = def("TestOptionInt")

let testOptionStr: schemaDrivenModule = def("TestOptionStr")
...
```


## SchemaDrivenRescriptStructPlugin
plugin thats extends base module api. adds module type 
```rescript
module type ModuleType = {
  include SchemaDrivenModule.SchemaDrivenModule

  let parse: Js.Json.t => result<t, exn>
  let parseAny: 'a => result<t, exn>
  let parseJson: string => result<t, exn>
  let parseAsync: Js.Json.t => promise<result<t, exn>>
  let serialize: t => result<Js.Json.t, exn>
  let serializeToUnknown: t => result<unknown, exn>
  let serializeToJson: t => result<string, exn>
}
```
and api realization for its.

For using add `SchemaDrivenRescriptStructPlugin.plugin` to engine's plugins array


## SchemaDrivenModifyModuleNamePlugin.resi
```rescript
open SchemaDrivenPlugin

//adds prefix to module name
let prefixPlugin: string => schemaDrivenPlugin

//adds postfix to module name
let postfixPlugin: string => schemaDrivenPlugin
```


## Plugins system and extensibility
types codegeneration produces struct of type `resultCodeDeclar`:
```rescript
//SchemaDrivenResultCode.res
type resultCodeDeclar = {
  moduleName: string, //moduleName
  t: string, //type declaration string
  struct: string, //rescript-struct declaration string
  moduleTypes: array<string>, //array of module-types
  funcDeclars: array<string>, //array of extra functions code
}
```
thats may be converted before printing.
plugins is functions type of 
```rescript
//SchemaDrivenPlugin.res
type schemaDrivenPlugin = resultCodeDeclar => resultCodeDeclar
```
use them for extends your generated types and add advanced api and module-types copability


## License
MIT


## Author
Anatoly Starodubtsev
tostar74@mail.ru
