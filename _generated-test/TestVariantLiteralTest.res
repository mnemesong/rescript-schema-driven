open RescriptMocha
open Mocha
open TestVariantLiteral

describe("TestVariantLiteralTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`"Apple"`)
        let result = parse(given)
        let nominal = Ok(Apple)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`"Orange"`)
        let result = parse(given)
        let nominal = Ok(Orange)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`"Lichi"`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = Banana
        let result = serialize(given)
        let nominal = Ok(%raw(`"Banana"`))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Orange
        let result = serialize(given)
        let nominal = Ok(%raw(`"Orange"`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = Orange
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Banana
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
