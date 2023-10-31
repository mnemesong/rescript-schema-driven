open RescriptMocha
open Mocha
open SchemaDrivenModule

describe("SchemaDrivenModuleTest", () => {
  it("test basics", () => {
    let given = "SomeModuleName"
    let result = moduleName(def(given))
    Assert.equal(result, given)
  })
})
