// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Belt_Array = require("rescript/lib/js/belt_Array.js");
var SchemaDrivenResultCode = require("./SchemaDrivenResultCode.bs.js");
var SchemaDrivenNamesCorrector = require("./SchemaDrivenNamesCorrector.bs.js");

function printStruct(variants) {
  var variantRows = Belt_Array.map(variants, (function (v) {
          var v$p = SchemaDrivenNamesCorrector.modifyVariantName(v);
          return "  S.literalVariant(String(\"" + v$p + "\"), " + v$p + ")";
        }));
  return "S.union([\n" + variantRows.join(",\n") + "\n])";
}

function printType(variants) {
  var variantRows = Belt_Array.map(variants, (function (v) {
          return "  | " + SchemaDrivenNamesCorrector.modifyVariantName(v);
        }));
  return "\n" + variantRows.join("\n");
}

function makeResultCode(moduleName, variants) {
  return SchemaDrivenResultCode.make(moduleName, printType(variants), printStruct(variants));
}

exports.printStruct = printStruct;
exports.printType = printType;
exports.makeResultCode = makeResultCode;
/* No side effect */