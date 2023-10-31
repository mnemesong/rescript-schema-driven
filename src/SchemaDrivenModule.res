type schemaDrivenModule

let def: (string, string, string) => schemaDrivenModule = %raw(`
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

  let struct: unit => S.t<t>
}
