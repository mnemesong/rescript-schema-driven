open RescriptMocha
open Mocha
open Belt

describe("SchemaDrivenFloatTest", () => {
  it("test assertion", () => {
    let result = %raw(`0.5`)->S.parseWith(SchemaDrivenFloat.struct)
    let nominal = Ok(0.5)
    Assert.deep_equal(result, nominal)
  })

  it("test invalid", () => {
    let result = %raw(`false`)->S.parseWith(SchemaDrivenFloat.struct)
    Assert.ok(Result.isError(result))
  })

  it("test serialization", () => {
    let given = -5.001
    let result =
      S.serializeToJsonWith(given, SchemaDrivenFloat.struct)->Result.flatMap(
        s => S.parseJsonWith(s, SchemaDrivenFloat.struct),
      )
    Assert.deep_equal(result, Ok(given))
  })
})
