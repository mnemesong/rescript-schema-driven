open RescriptMocha
open Mocha
open TestArray

describe("TestArrayTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`["", "dsja", "*Sdn das_"]`)
        let result = parse(given)
        let nominal = Ok(["", "dsja", "*Sdn das_"])
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`[]`)
        let result = parse(given)
        let nominal = Ok([])
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`"sdas"`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = ["", "dsja", "*Sdn das_"]
        let result = serialize(given)
        let nominal = Ok(%raw(`["", "dsja", "*Sdn das_"]`))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = []
        let result = serialize(given)
        let nominal = Ok(%raw(`[]`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = ["", "dsja", "*Sdn das_"]
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = []
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
