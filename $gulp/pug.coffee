cfg = require './config'

_ = require 'lodash'
path = require 'path'
gulp = require 'gulp'
pug = require 'gulp-pug'

glob = '**/*.pug'
compile = (locals = {}) ->
    getSources glob
        .pipe pug
            pretty: true
        .on 'error', errorHndl
        .pipe gulp.dest cfg.path.build

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
