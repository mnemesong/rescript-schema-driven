// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Belt_Result = require("rescript/lib/js/belt_Result.js");
var S$RescriptStruct = require("rescript-struct/lib/js/src/S.bs.js");
var SchemaDrivenString = require("../src/SchemaDrivenString.bs.js");
var Mocha$RescriptMocha = require("rescript-mocha/lib/js/src/Mocha.bs.js");
var Assert$RescriptMocha = require("rescript-mocha/lib/js/src/Assert.bs.js");

Mocha$RescriptMocha.describe("SchemaDrivenStringTest")(undefined, undefined, undefined, (function (param) {
        Mocha$RescriptMocha.it("test assertion")(undefined, undefined, undefined, (function (param) {
                var result = S$RescriptStruct.parseWith("dsafsa", SchemaDrivenString.struct);
                Assert$RescriptMocha.deep_equal(undefined, result, {
                      TAG: /* Ok */0,
                      _0: "dsafsa"
                    });
              }));
        Mocha$RescriptMocha.it("test invalid")(undefined, undefined, undefined, (function (param) {
                var result = S$RescriptStruct.parseWith([], SchemaDrivenString.struct);
                Assert$RescriptMocha.ok(Belt_Result.isError(result));
              }));
        Mocha$RescriptMocha.it("test serialization")(undefined, undefined, undefined, (function (param) {
                var given = "dsafsa";
                var result = Belt_Result.flatMap(S$RescriptStruct.serializeToJsonWith(given, undefined, SchemaDrivenString.struct), (function (s) {
                        return S$RescriptStruct.parseJsonWith(s, SchemaDrivenString.struct);
                      }));
                Assert$RescriptMocha.deep_equal(undefined, result, {
                      TAG: /* Ok */0,
                      _0: given
                    });
              }));
      }));

/*  Not a pure module */
