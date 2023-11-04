type testVariantLiteral = 
  | Banana
  | Orange
  | Apple

include SchemaDrivenModule.SchemaDrivenVariantModule
include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testVariantLiteral