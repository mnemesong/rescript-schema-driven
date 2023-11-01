type testTupleObject = (
  SchemaDrivenInt.t,
  TestOptionStr.t,
  SchemaDrivenBool.t
)

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testTupleObject