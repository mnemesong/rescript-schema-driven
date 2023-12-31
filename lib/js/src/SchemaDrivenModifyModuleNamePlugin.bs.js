// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var SchemaDrivenResultCode = require("./SchemaDrivenResultCode.bs.js");
var SchemaDrivenNamesCorrector = require("./SchemaDrivenNamesCorrector.bs.js");

function prefixPlugin(prefix, resultCodeDeclar) {
  return SchemaDrivenResultCode.editModuleTypes(SchemaDrivenResultCode.editModuleName(resultCodeDeclar, (function (n) {
                    return SchemaDrivenNamesCorrector.modifyModuleName(prefix) + n;
                  })), (function (t) {
                return t.replace("type t = " + SchemaDrivenNamesCorrector.modifyVariableName(resultCodeDeclar.moduleName), "type t = " + SchemaDrivenNamesCorrector.modifyVariableName(SchemaDrivenNamesCorrector.modifyModuleName(prefix) + resultCodeDeclar.moduleName));
              }));
}

function postfixPlugin(postfix, resultCodeDeclar) {
  return SchemaDrivenResultCode.editModuleTypes(SchemaDrivenResultCode.editModuleName(resultCodeDeclar, (function (n) {
                    return n + SchemaDrivenNamesCorrector.modifyModuleName(postfix);
                  })), (function (t) {
                return t.replace("type t = " + SchemaDrivenNamesCorrector.modifyVariableName(resultCodeDeclar.moduleName), "type t = " + SchemaDrivenNamesCorrector.modifyVariableName(resultCodeDeclar.moduleName + SchemaDrivenNamesCorrector.modifyModuleName(postfix)));
              }));
}

exports.prefixPlugin = prefixPlugin;
exports.postfixPlugin = postfixPlugin;
/* No side effect */
