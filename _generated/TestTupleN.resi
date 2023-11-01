type testTupleN = (
  SchemaDrivenString.t,
  TestPerson.t,
  TestOptionInt.t
)

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testTupleN