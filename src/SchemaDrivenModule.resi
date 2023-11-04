type schemaDrivenModule

let def: string => schemaDrivenModule

let moduleName: schemaDrivenModule => string

module type SchemaDrivenModule = {
  type t

  let struct: S.t<t>
}

module type SchemaDrivenVariantModule = {
  let allVariants: array<string>
}
