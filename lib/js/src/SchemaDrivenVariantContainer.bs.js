// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");
var SchemaDrivenModule = require("./SchemaDrivenModule.bs.js");
var SchemaDrivenResultCode = require("./SchemaDrivenResultCode.bs.js");
var SchemaDrivenNamesCorrector = require("./SchemaDrivenNamesCorrector.bs.js");

function printStruct(variants, tagName, strict) {
  var strictAnnot = strict ? "->S.Object.strict" : "->S.Object.strip";
  var variantRows = Belt_Array.map(variants, (function (v) {
          var varName$p = SchemaDrivenNamesCorrector.modifyVariantName(v._0);
          var typeRows = Belt_Array.mapWithIndex(v._1, (function (i, t) {
                  var propName = "t_" + String(i);
                  return "      o->S.field(\"" + propName + "\", " + SchemaDrivenModule.moduleName(t) + ".struct)";
                }));
          var varParams = typeRows.length !== 0 ? "(\n" + typeRows.join(",\n") + "\n    )" : "";
          return "  S.object(o => {\n    ignore(o->S.field(\"" + tagName + "\", S.literal(String(\"" + varName$p + "\"))))\n    " + varName$p + "" + varParams + "\n  })" + strictAnnot + "";
        }));
  return "S.union([\n" + variantRows.join(",\n") + "\n])";
}

function printType(variants) {
  var variantRows = Belt_Array.map(variants, (function (v) {
          var typeRows = Belt_Array.map(v._1, (function (t) {
                  return SchemaDrivenModule.moduleName(t) + ".t";
                }));
          var varParams = typeRows.length !== 0 ? "(" + typeRows.join(", ") + ")" : "";
          return "  | " + SchemaDrivenNamesCorrector.modifyVariantName(v._0) + "" + varParams;
        }));
  return "\n" + variantRows.join("\n");
}

function allVariantsFunc(variants) {
  var allNames = Belt_Array.map(variants, (function (v) {
          return v._0;
        }));
  return "let allVariants = " + Belt_Option.getExn(JSON.stringify(allNames));
}

function makeResultCode(moduleName, variants, tagName, strict) {
  return SchemaDrivenResultCode.addModuleType(SchemaDrivenResultCode.addFuncs(SchemaDrivenResultCode.make(moduleName, printType(variants), printStruct(variants, tagName, strict)), [allVariantsFunc(variants)]), "SchemaDrivenModule.SchemaDrivenVariantModule");
}

exports.printStruct = printStruct;
exports.printType = printType;
exports.makeResultCode = makeResultCode;
/* No side effect */
