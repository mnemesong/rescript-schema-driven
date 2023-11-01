open RescriptMocha
open Mocha
open TestVariantObject

describe("TestVariantObjectTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{TAG: "Square", width: 15.2, height: 10}`)
        let result = parse(given)
        let nominal = Ok(Square({width: 15.2, height: 10.0}))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{TAG: "Square", radius: 15.2}`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = Square({width: 15.2, height: 10.0})
        let result = serialize(given)
        let nominal = Ok(%raw(`{TAG: "Square", width: 15.2, height: 10}`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = Square({width: 15.2, height: 10.0})
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Circle({radius: -3.1})
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
