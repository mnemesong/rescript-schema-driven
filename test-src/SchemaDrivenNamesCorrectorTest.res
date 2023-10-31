open RescriptMocha
open Mocha
open SchemaDrivenNamesCorrector

describe("SchemaDrivenNamesCorrectorTest", () => {
  describe("test modifyVariableName", () => {
    it(
      "test 1",
      () => {
        let given = "Mom-givesMe*_a(Soap )"
        let nominal = "momgivesMe_aSoap"
        let result = modifyVariableName(given)
        Assert.equal(result, nominal)
      },
    )
    it(
      "test 2",
      () => {
        let given = "wellVarName"
        let nominal = "wellVarName"
        let result = modifyVariableName(given)
        Assert.equal(result, nominal)
      },
    )
  })

  describe("test modifyVariantName", () => {
    it(
      "test 1",
      () => {
        let given = "mom-givesMe*_a(Soap )"
        let nominal = "MomgivesMe_aSoap"
        let result = modifyVariantName(given)
        Assert.equal(result, nominal)
      },
    )
    it(
      "test 2",
      () => {
        let given = "WellVarName_"
        let nominal = "WellVarName_"
        let result = modifyVariantName(given)
        Assert.equal(result, nominal)
      },
    )
  })

  describe("test modifyModuleName", () => {
    it(
      "test 1",
      () => {
        let given = "mom-givesMe*_a(Soap )"
        let nominal = "MomgivesMe_aSoap"
        let result = modifyModuleName(given)
        Assert.equal(result, nominal)
      },
    )
    it(
      "test 2",
      () => {
        let given = "WellVarName_"
        let nominal = "WellVarName_"
        let result = modifyModuleName(given)
        Assert.equal(result, nominal)
      },
    )
  })
})
