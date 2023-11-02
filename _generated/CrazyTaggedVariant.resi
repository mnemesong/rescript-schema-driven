type crazyTaggedVariant = 
  | Fruit(TestVariantLiteral.t)
  | FruitSet(TestArray.t)

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = crazyTaggedVariant