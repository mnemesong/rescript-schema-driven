open RescriptMocha
open Mocha
open TestList

describe("TestListTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`[0, -576.12, 8]`)
        let result = parse(given)
        let nominal = Ok(list{0.0, -576.12, 8.0})
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`[]`)
        let result = parse(given)
        let nominal = Ok(list{})
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`["sdas"]`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = list{0.0, -576.12, 8.0}
        let result = serialize(given)
        let nominal = Ok(%raw(`[0, -576.12, 8]`))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = list{}
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
        let given = list{0.0, -576.12, 8.0}
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = list{}
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
