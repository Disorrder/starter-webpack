cfg = require './config'

path = require 'path'
gulp = require 'gulp'
filter = require 'gulp-filter'
concat = require 'gulp-concat'
wrap = require 'gulp-wrap'
mainBowerFiles = require 'main-bower-files'
hash = require 'gulp-hash-filename'

glob = 'bower.json'
compile = ->
    files = mainBowerFiles()
    jsFilter = filter "**/*.js", {restore: true}
    cssFilter = filter "**/*.css", {restore: true}
    gulp.src files, {base: cfg.path.bower}
        .pipe jsFilter
        .pipe wrap "/* --- <%= file.relative %> --- */\n<%= contents %>"
        .pipe concat 'scripts/vendor.js'
        .pipe runIfProd -> hash {format: '{name}-{hash:6}{ext}'}
        .pipe jsFilter.restore
        # Can't concat because of libs' assets (like fonts, images, etc.)
        # .pipe cssFilter
        # .pipe wrap "/* --- <%= file.relative %> --- */\n<%= contents %>"
        # .pipe concat path.join 'bower_components', 'libs.css'
        # .pipe cssFilter.restore
        .pipe gulp.dest cfg.path.build

mathjax = -> # TODO
    gulp.src "#{cfg.path.bower}/bower_components/MathJax/**/*.js"
        .pipe gulp.dest cfg.path.build

module.exports = compile
module.exports.watch = path.join cfg.path.build, glob
