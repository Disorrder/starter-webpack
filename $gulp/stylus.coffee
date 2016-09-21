cfg = require './config'

path = require 'path'
gulp = require 'gulp'
change = require 'gulp-change'
concat = require 'gulp-concat'
stylus = require 'gulp-stylus'
hash = require 'gulp-hash-filename'
nib = require 'nib'
merge = require 'merge-stream'

params = {
    # read: false # not working :c
    cwd: cfg.path.app
    base: cfg.path.app
}

glob = '**/*.styl'

compile = ->
    streams = merge()

    streams.add( getSources glob
        .pipe change (content) ->
            importPath = @file.relative.replace(/\\/g, '/')
            "@import '#{importPath}'"
        .pipe concat 'app.styl'
        .pipe stylus {use: nib(), import: ['nib']} #? use and import?
        .pipe runIfProd -> hash {format: '{name}-{hash:6}{ext}'}
        .on 'error', errorHndl
        .pipe gulp.dest path.join cfg.path.build, 'styles'
    )

    return streams

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
