open RescriptMocha
open Mocha
open TestOptionInt

describe("TestOptionIntTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`12`)
        let result = parse(given)
        let nominal = Ok(Some(12))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`null`)
        let result = parse(given)
        let nominal = Ok(None)
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = Some(12)
        let result = serialize(given)
        let nominal = Ok(%raw(`12`))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = None
        let result = serialize(given)
        let nominal = Ok(%raw(`null`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = Some(12)
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = None
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
