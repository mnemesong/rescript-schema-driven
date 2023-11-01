open RescriptMocha
open Mocha
open TestTupleObject

describe("TestTupleObjectTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{t_0: 12, t_1: null, t_2: true}`)
        let result = parse(given)
        let nominal = Ok((12, None, true))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{t_0: 12, t_1: false, t_2: true}`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = (12, Some("aboba"), true)
        let result = serialize(given)
        let nominal = Ok(%raw(`{t_0: 12, t_1: "aboba", t_2: true}`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = (12, None, true)
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = (-6, Some("dsak- asdkjl"), false)
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
