open RescriptMocha
open Mocha
open TestDict

describe("TestDictTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{
          v1: "foo",
          v2: null
        }`)
        let result = parse(given)
        let nominal = Ok(Js.Dict.fromArray([("v1", Some("foo")), ("v2", None)]))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{
          v1: "foo",
          v2: 0
        }`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = Js.Dict.fromArray([("v1", Some("foo")), ("v2", None)])
        let result = serialize(given)
        let nominal = Ok(
          %raw(`{
          v1: "foo",
          v2: null
        }`),
        )
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Js.Dict.fromArray([])
        let result = serialize(given)
        let nominal = Ok(%raw(`{}`))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = Js.Dict.fromArray([("v1", Some("foo")), ("v2", None)])
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = Js.Dict.fromArray([])
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
