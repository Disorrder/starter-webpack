cfg = require './config'

path = require 'path'
gulp = require 'gulp'
wrap = require 'gulp-wrap'
concat = require 'gulp-concat'
less = require 'gulp-less'

glob = '**/*.less'
compile = ->
    getSources glob
        # .pipe wrap '@import "<%= file.relative %>";\n'
        .pipe concat 'application/styles.less'
        .pipe less()
        .on 'error', errorHndl
        .pipe gulp.dest cfg.path.build

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
