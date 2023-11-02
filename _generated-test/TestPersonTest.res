open RescriptMocha
open Mocha
open TestPerson

describe("TestPersonTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{
          id: 5,
          ages: 8,
          name: "John"
        }`)
        let result = parse(given)
        let nominal = Ok({
          id: 5,
          ages: Some(8),
          name: "John",
        })
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`{
          id: 5,
          ages: null,
          name: ""
        }`)
        let result = parse(given)
        let nominal = Ok({
          id: 5,
          ages: None,
          name: "",
        })
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 3",
      () => {
        let given = %raw(`{
          id: 5,
          ages: null,
          name: "",
          extra1: true,
          extra2: {val: 12}
        }`)
        let result = parse(given)
        let nominal = Ok({
          id: 5,
          ages: None,
          name: "",
        })
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{
          id: 5,
          ages: "dsasf",
          name: ""
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
        let given = {
          id: 5,
          ages: Some(8),
          name: "John",
        }
        let result = serialize(given)
        let nominal = Ok(
          %raw(`{
          id: 5,
          ages: 8,
          name: "John"
        }`),
        )
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = {
          id: 5,
          ages: Some(8),
          name: "John",
        }
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
    it(
      "test valid 2",
      () => {
        let given = {
          id: 5,
          ages: None,
          name: "",
        }
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
