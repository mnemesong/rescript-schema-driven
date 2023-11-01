// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var ResultExn = require("rescript-result-exn/lib/js/src/ResultExn.bs.js");
var Belt_Result = require("rescript/lib/js/belt_Result.js");
var Mocha$RescriptMocha = require("rescript-mocha/lib/js/src/Mocha.bs.js");
var Assert$RescriptMocha = require("rescript-mocha/lib/js/src/Assert.bs.js");
var TestVariantContainer = require("../_generated/TestVariantContainer.bs.js");

Mocha$RescriptMocha.describe("TestVariantContainerTest")(undefined, undefined, undefined, (function (param) {
        Mocha$RescriptMocha.describe("test parse")(undefined, undefined, undefined, (function (param) {
                Mocha$RescriptMocha.it("test valid 1")(undefined, undefined, undefined, (function (param) {
                        var given = {TAG: "Var1", t_0: 15.2};
                        var result = TestVariantContainer.parse(given);
                        Assert$RescriptMocha.deep_equal(undefined, result, {
                              TAG: /* Ok */0,
                              _0: {
                                TAG: /* Var1 */0,
                                _0: 15.2
                              }
                            });
                      }));
                Mocha$RescriptMocha.it("test valid 2")(undefined, undefined, undefined, (function (param) {
                        var given = {TAG: "Var2", t_0: null, t_1: -1};
                        var result = TestVariantContainer.parse(given);
                        Assert$RescriptMocha.deep_equal(undefined, result, {
                              TAG: /* Ok */0,
                              _0: {
                                TAG: /* Var2 */1,
                                _0: undefined,
                                _1: -1.0
                              }
                            });
                      }));
                Mocha$RescriptMocha.it("test invalid")(undefined, undefined, undefined, (function (param) {
                        var given = {TAG: "Var2", t_0: false};
                        var result = TestVariantContainer.parse(given);
                        Assert$RescriptMocha.ok(Belt_Result.isError(result));
                      }));
              }));
        Mocha$RescriptMocha.describe("test serialize")(undefined, undefined, undefined, (function (param) {
                Mocha$RescriptMocha.it("test valid 1")(undefined, undefined, undefined, (function (param) {
                        var result = TestVariantContainer.serialize({
                              TAG: /* Var2 */1,
                              _0: undefined,
                              _1: -1.0
                            });
                        var nominal = {
                          TAG: /* Ok */0,
                          _0: {TAG: "Var2", t_0: null, t_1: -1}
                        };
                        Assert$RescriptMocha.deep_equal(undefined, result, nominal);
                      }));
              }));
        Mocha$RescriptMocha.describe("test json")(undefined, undefined, undefined, (function (param) {
                Mocha$RescriptMocha.it("test valid 1")(undefined, undefined, undefined, (function (param) {
                        var given = {
                          TAG: /* Var2 */1,
                          _0: undefined,
                          _1: -1.0
                        };
                        var result = ResultExn.flatMap(TestVariantContainer.serializeToJson(given), TestVariantContainer.parseJson);
                        Assert$RescriptMocha.deep_equal(undefined, result, {
                              TAG: /* Ok */0,
                              _0: given
                            });
                      }));
                Mocha$RescriptMocha.it("test valid 2")(undefined, undefined, undefined, (function (param) {
                        var given = {
                          TAG: /* Var3 */2,
                          _0: "kdoaos"
                        };
                        var result = ResultExn.flatMap(TestVariantContainer.serializeToJson(given), TestVariantContainer.parseJson);
                        Assert$RescriptMocha.deep_equal(undefined, result, {
                              TAG: /* Ok */0,
                              _0: given
                            });
                      }));
              }));
      }));

/*  Not a pure module */