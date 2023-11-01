type testProfile = {
  "person":  TestPerson.t,
  "descr":  TestOptionStr.t
}

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testProfile