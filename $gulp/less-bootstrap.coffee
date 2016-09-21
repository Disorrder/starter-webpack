cfg = require './config'

path = require 'path'
gulp = require 'gulp'
wrap = require 'gulp-wrap'
concat = require 'gulp-concat'
less = require 'gulp-less'

glob = 'bootstrap/**/*.less'
compile = ->
    getSources glob
        .pipe wrap '@import "<%= file.relative %>";\n'
        .pipe concat 'bootstrap.less'
        .pipe less()
        # .pipe concat 'bower_components/bootstrap/css/bootstrap.css'
        .on 'error', errorHndl
        .pipe gulp.dest path.join cfg.path.bower, 'bower_components/bootstrap/dist/css'

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
