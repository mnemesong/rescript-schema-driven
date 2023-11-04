type crazyTaggedVariant = 
  | Fruit(TestVariantLiteral.t)
  | FruitSet(TestArray.t)

include SchemaDrivenModule.SchemaDrivenVariantModule
include SchemaDrivenRescriptStructPlugin.ModuleType with type t = crazyTaggedVariant