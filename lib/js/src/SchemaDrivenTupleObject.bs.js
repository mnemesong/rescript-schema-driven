// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Belt_Array = require("rescript/lib/js/belt_Array.js");
var SchemaDrivenModule = require("./SchemaDrivenModule.bs.js");
var SchemaDrivenResultCode = require("./SchemaDrivenResultCode.bs.js");

function printStruct(props) {
  var propRows = Belt_Array.map(props, (function (p) {
          return "  o->S.field(\"" + p._0 + "\", " + SchemaDrivenModule.moduleName(p._1) + ".struct)";
        }));
  return "S.object(o => (\n" + propRows.join(",\n") + "\n))";
}

function printType(props) {
  var propRows = Belt_Array.map(props, (function (p) {
          return "  " + SchemaDrivenModule.moduleName(p._1) + ".t";
        }));
  return "(\n" + propRows.join(",\n") + "\n)";
}

function makeResultCode(moduleName, types) {
  var p = Belt_Array.mapWithIndex(types, (function (i, m) {
          return /* Field */{
                  _0: "t_" + String(i),
                  _1: m
                };
        }));
  return SchemaDrivenResultCode.make(moduleName, printType(p), printStruct(p));
}

exports.printStruct = printStruct;
exports.printType = printType;
exports.makeResultCode = makeResultCode;
/* No side effect */