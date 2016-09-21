cfg = require './config'

path = require 'path'
gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
angularFileSort = require 'gulp-angular-filesort'
hash = require 'gulp-hash-filename'
addsrc = require 'gulp-add-src'

glob = '**/*.coffee'
compile = ->
    getSources glob
        .pipe coffee
            pretty: true
        .on 'error', errorHndl
        .pipe runIfProd -> angularFileSort()
        .pipe runIfProd -> concat 'scripts/app.js'
        .pipe runIfProd -> hash {format: '{name}-{hash:6}{ext}'}
        .pipe addsrc path.join cfg.path.app, 'config.js'
        .pipe gulp.dest cfg.path.build

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
