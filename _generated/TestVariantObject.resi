type testVariantObject = 
  | Circle({
      radius: SchemaDrivenFloat.t
    })
  | Square({
      width: SchemaDrivenFloat.t,
      height: SchemaDrivenFloat.t
    })

include SchemaDrivenRescriptStructPlugin.ModuleType with type t = testVariantObject