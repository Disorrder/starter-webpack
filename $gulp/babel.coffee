cfg = require './config'

path = require 'path'
gulp = require 'gulp'
babel = require 'gulp-babel'

glob = '**/*.{js,es6}'
compile = ->
    getSources glob
        .pipe babel
            presets: ['es2015']
        .on 'error', errorHndl
        .pipe gulp.dest cfg.path.build

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
