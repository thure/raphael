#!/usr/bin/env node
var setup = {
        input: {
            copy: "copy.js",
            core: "src/raphael.core.js",
            svg: "src/raphael.svg.js",
            vml: "src/raphael.vml.js",
            eve: "lib/eve.js",
        },
        output: {
            "raphael-min.js": function () {
                return this.copy + "\n" + minify(this.eve + this.core + this.svg + this.vml);
            },
            "raphael.js": function () {
                return this.copy + "\n" + this.eve + "\n\n" + this.core + "\n\n" + this.svg + "\n\n" + this.vml;
            }
        }
    },
    ujs = require("uglify-js"),
    jsp = ujs.parser,
    pro = ujs.uglify,
    fs = require("fs"),
    rxdr = /\/\*\\[\s\S]+?\\\*\//g;

function minify(code) {
    return pro.gen_code(pro.ast_squeeze(pro.ast_mangle(jsp.parse(code))));
}

var files = {};
for (var file in setup.input) {
    files[file] = String(fs.readFileSync(setup.input[file], "utf8")).replace(rxdr, "");
}
for (file in setup.output) {
    (function (file) {
        fs.writeFile(file, setup.output[file].call(files), function () {
            console.log("Saved to \033[32m" + file + "\033[0m\n");
        });
    })(file);
}