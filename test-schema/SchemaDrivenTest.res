open SchemaDriven

let _genDir: string = %raw(`require("path").resolve(module.path, "..", "..", "..", "_generated")`)

let eng = defEngine(_genDir, [], RemoveAllFilesFromDir)->Belt.Result.getExn

let testOptionInt = optionNull("TestOptionInt", int, eng)
