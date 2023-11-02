open RescriptMocha
open Mocha
open CrazyTaggedVariant

describe("CrazyTaggedVariantTest", () => {
  describe("test parse", () => {
    it(
      "test valid 1",
      () => {
        let given = %raw(`{
          crazyTaggedVariant: "FruitSet",
          t_0: ["Lichi", "Pinapple"]
        }`)
        let result = parse(given)
        let nominal = Ok(FruitSet(["Lichi", "Pinapple"]))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "test invalid strip",
      () => {
        let given = %raw(`{
          crazyTaggedVariant: "FruitSet",
          t_0: ["Lichi", "Pinapple"],
          t_1: "extraval"
        }`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
    it(
      "test invalid",
      () => {
        let given = %raw(`{
          TAG: "FruitSet",
          t_0: ["Lichi", "Pinapple"]
        }`)
        let result = parse(given)
        Assert.ok(result->Belt.Result.isError)
      },
    )
  })

  describe("test json", () => {
    it(
      "test valid 1",
      () => {
        let given = FruitSet(["Lichi", "Pinapple"])
        let result = given->serializeToJson->ResultExn.flatMap(j => j->parseJson)
        Assert.deep_equal(result, Ok(given))
      },
    )
  })
})
