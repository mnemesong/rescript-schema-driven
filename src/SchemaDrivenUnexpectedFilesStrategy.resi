type unexpectedFilesStrategy =
  | RemoveAllFilesFromDir
  | RemoveOnlyInMatch
  | ThrowErrorOnMatch

let removeOnMatch: unexpectedFilesStrategy => bool

let cleanDirectory: string => result<unit, exn>

let writeFileSync: (string, string, bool) => result<unit, exn>
