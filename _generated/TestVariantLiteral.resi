type testVariantLiteral = 
  | Banana
  | Orange
  | Apple

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testVariantLiteral