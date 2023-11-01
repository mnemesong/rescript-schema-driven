type testPerson = {
  id:  SchemaDrivenInt.t,
  ages:  TestOptionInt.t,
  name:  SchemaDrivenString.t
}

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testPerson