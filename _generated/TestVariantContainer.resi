type testVariantContainer = 
  | Var1(SchemaDrivenFloat.t)
  | Var2(TestOptionStr.t, SchemaDrivenFloat.t)
  | Var3(SchemaDrivenString.t)

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testVariantContainer