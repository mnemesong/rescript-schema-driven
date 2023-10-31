type unexpectedFilesStrategy =
  | RemoveAllFilesFromDir
  | RemoveOnlyInMatch
  | ThrowErrorOnMatch

let removeOnMatch = (unexpectedFilesStrategy: unexpectedFilesStrategy): bool =>
  switch unexpectedFilesStrategy {
  | RemoveOnlyInMatch => true
  | _ => false
  }

let cleanDirectory = (path: string): result<unit, exn> => {
  let clean: string => unit = %raw(`
  function (directory) {
    const fs = require("fs");
    const path = require("path");
    const files = fs.readdirSync(directory);
    for (const file of files) {
      fs.unlinkSync(path.join(directory, file));
    }
  }
  `)
  ResultExn.tryExec(() => clean(path))
}

let writeFileSync = (file: string, data: string, removeOnMatch: bool): result<unit, exn> => {
  let f: (string, string, bool) => unit = %raw(`
  function (file, data, removeOnMatch) {
    let fs = require("fs");
    if(fs.existsSync(file)) {
      if(removeOnMatch) {
        fs.unlinkSync(file);
      } else {
        throw new Error("File " + file + " exists yet");
      }
    }
    fs.writeFileSync(file, data);
  }
  `)
  ResultExn.tryExec(() => f(file, data, removeOnMatch))
}
