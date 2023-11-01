open RescriptMocha
open Mocha
open TestPerson
open! TestTupleN

describe("TestTupleNTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`["dsfas asd", {
          id:  41,
          ages:  null,
          name:  "Mary"
        }, 24]`)
        let result = parse(given)
        let nominal = Ok((
          "dsfas asd",
          {
            id: 41,
            ages: None,
            name: "Mary",
          },
          Some(24),
        ))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`["dsfas asd", {
          id:  41,
          name:  "Mary"
        }, 24]`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test serialize", () => {
    it(
      "test valid 1",
      () => {
        let given = (
          "dsfas asd",
          {
            id: 41,
            ages: None,
            name: "Mary",
          },
          Some(24),
        )
        let result = serialize(given)
        let nominal = Ok(
          %raw(`["dsfas asd", {
          id:  41,
          ages:  null,
          name:  "Mary"
        }, 24]`),
        )
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = (
          "dsfas asd",
          {
            id: 41,
            ages: None,
            name: "Mary",
          },
          Some(24),
        )
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = (
          "",
          {
            id: 41,
            ages: Some(-3),
            name: "",
          },
          None,
        )
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
