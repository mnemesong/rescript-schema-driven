open SchemaDrivenModule

type rec primitiveType =
  | Int
  | Float
  | String
  | Bool
  | Unit

let just = (t: primitiveType): schemaDrivenModule =>
  switch t {
  | Int => def("SchemaDrivenInt")
  | Float => def("SchemaDrivenFloat")
  | String => def("SchemaDrivenString")
  | Bool => def("SchemaDrivenBool")
  | Unit => def("SchemaDrivenUnit")
  }
