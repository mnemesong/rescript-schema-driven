open RescriptMocha
open Mocha
open TestPerson
open! TestProfile

describe("TestProfileTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{
          person: {
            id: 5,
            ages: 8,
            name: "John"
          },
          descr: "some descr"
        }`)
        let result = parse(given)
        let nominal = Ok({
          "person": {
            id: 5,
            ages: Some(8),
            name: "John",
          },
          "descr": Some("some descr"),
        })
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test valid 2",
      () => {
        let given = %raw(`{
          person: {
            id: 5,
            ages: null,
            name: ""
          },
          descr: null
        }`)
        let result = parse(given)
        let nominal = Ok({
          "person": {
            id: 5,
            ages: None,
            name: "",
          },
          "descr": None,
        })
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{
          person: {
            id: 5,
            ages: null,
            name: ""
          },
          descr: 12
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
          "person": {
            id: 5,
            ages: Some(8),
            name: "John",
          },
          "descr": None,
        }
        let result = serialize(given)
        let nominal = Ok(
          %raw(`{
            person: {
              id: 5,
              ages: 8,
              name: "John"
            },
            descr: null
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
          "person": {
            id: 5,
            ages: Some(8),
            name: "John",
          },
          "descr": None,
        }
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
