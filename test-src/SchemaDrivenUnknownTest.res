open RescriptMocha
open Mocha
open Belt

describe("SchemaDrivenUnknownTest", () => {
  it("test assertion", () => {
    let result = %raw(`"dsafsa"`)->S.parseWith(SchemaDrivenUnknown.struct)
    let nominal = Ok(%raw(`"dsafsa"`))
    Assert.deep_equal(result, nominal)
  })
  it("test assertion2", () => {
    let result = %raw(`18.2`)->S.parseWith(SchemaDrivenUnknown.struct)
    let nominal = Ok(%raw(`18.2`))
    Assert.deep_equal(result, nominal)
  })
  it("test assertion", () => {
    let result = %raw(`{id: null}`)->S.parseWith(SchemaDrivenUnknown.struct)
    let nominal = Ok(%raw(`{id: null}`))
    Assert.deep_equal(result, nominal)
  })

  it("test serialization", () => {
    let given = %raw(`{id: null}`)
    let result =
      S.serializeToJsonWith(given, SchemaDrivenUnknown.struct)->Result.flatMap(
        s => S.parseJsonWith(s, SchemaDrivenUnknown.struct),
      )
    Assert.ok(result->Result.isError)
  })
})
