open RescriptMocha
open Mocha
open TestVariantContainer

describe("TestVariantContainerTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{TAG: "Var1", t_0: 15.2}`)
        let result = parse(given)
        let nominal = Ok(Var1(15.2))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`{TAG: "Var2", t_0: null, t_1: -1}`)
        let result = parse(given)
        let nominal = Ok(Var2(None, -1.0))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{TAG: "Var2", t_0: false}`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = Var2(None, -1.0)
        let result = serialize(given)
        let nominal = Ok(%raw(`{TAG: "Var2", t_0: null, t_1: -1}`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = Var2(None, -1.0)
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Var3("kdoaos")
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
