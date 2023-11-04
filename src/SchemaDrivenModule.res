type schemaDrivenModule

let def: string => schemaDrivenModule = %raw(`
function (moduleName) {
  return {
    module: moduleName
  };
}
`)

let moduleName: schemaDrivenModule => string = %raw(`
function (typeRef) {
  return typeRef.module;
}
`)

module type SchemaDrivenModule = {
  type t

  let struct: S.t<t>
}

module type SchemaDrivenVariantModule = {
  let allVariants: array<string>
}
