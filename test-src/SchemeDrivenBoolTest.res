open RescriptMocha
open Mocha
open Belt

describe("SchemaDrivenBoolTest", () => {
  it("test assertion", () => {
    let result = %raw(`false`)->S.parseWith(SchemaDrivenBool.struct)
    let nominal = Ok(false)
    Assert.deep_equal(result, nominal)
  })

  it("test invalid", () => {
    let result = %raw(`1`)->S.parseWith(SchemaDrivenBool.struct)
    Assert.ok(Result.isError(result))
  })

  it("test serialization", () => {
    let given = true
    let result =
      S.serializeToJsonWith(given, SchemaDrivenBool.struct)->Result.flatMap(
        s => S.parseJsonWith(s, SchemaDrivenBool.struct),
      )
    Assert.deep_equal(result, Ok(given))
  })
})
