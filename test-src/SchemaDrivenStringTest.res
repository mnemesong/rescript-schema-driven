open RescriptMocha
open Mocha
open Belt

describe("SchemaDrivenStringTest", () => {
  it("test assertion", () => {
    let result = %raw(`"dsafsa"`)->S.parseWith(SchemaDrivenString.struct)
    let nominal = Ok("dsafsa")
    Assert.deep_equal(result, nominal)
  })

  it("test invalid", () => {
    let result = %raw(`[]`)->S.parseWith(SchemaDrivenString.struct)
    Assert.ok(Result.isError(result))
  })

  it("test serialization", () => {
    let given = "dsafsa"
    let result =
      S.serializeToJsonWith(given, SchemaDrivenString.struct)->Result.flatMap(
        s => S.parseJsonWith(s, SchemaDrivenString.struct),
      )
    Assert.deep_equal(result, Ok(given))
  })
})
