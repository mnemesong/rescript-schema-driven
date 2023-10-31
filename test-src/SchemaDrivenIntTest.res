open RescriptMocha
open Mocha
open Belt

describe("SchemaDrivenIntTest", () => {
  it("test assertion", () => {
    let result = %raw(`22`)->S.parseWith(SchemaDrivenInt.struct)
    let nominal = Ok(22)
    Assert.deep_equal(result, nominal)
  })

  it("test invalid", () => {
    let result = %raw(`""`)->S.parseWith(SchemaDrivenBool.struct)
    Assert.ok(Result.isError(result))
  })

  it("test serialization", () => {
    let given = -11
    let result =
      S.serializeToJsonWith(given, SchemaDrivenInt.struct)->Result.flatMap(
        s => S.parseJsonWith(s, SchemaDrivenInt.struct),
      )
    Assert.deep_equal(result, Ok(given))
  })
})
