type testVariantObject = 
  | Circle({
      radius: SchemaDrivenFloat.t
    })
  | Square({
      width: SchemaDrivenFloat.t,
      height: SchemaDrivenFloat.t
    })

include SchemaDrivenModule.SchemaDrivenVariantModule
include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testVariantObject