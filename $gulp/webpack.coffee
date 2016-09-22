cfg = require './config'

fs = require 'fs'
path = require 'path'
gulp = require 'gulp'
change = require 'gulp-change'
concat = require 'gulp-concat'
util = require 'gulp-util'
webpack = require 'webpack-stream'
webpackConfig = require '../webpack.config.js'
files = require './lib/build'

glob = '**/*.coffee'
compile = (cb) ->
    if webpackConfig.module.autoRequire
        entryFile = path.join cfg.path.app, 'app/app.entry.coffee'
        scripts = files.getByGlob [glob, '!**/*.entry.coffee' ], path.join cfg.path.app, 'app'
        scripts = scripts.map (v) ->
            "require '.#{v}'"
        scripts = scripts.join '\n'

        oldScripts = fs.readFileSync entryFile
        
        if scripts != oldScripts.toString()
            fs.writeFileSync entryFile, scripts

    getSources '**/*.entry.coffee'
        # .pipe change (content) ->
        #     importPath = @file.relative.replace(/\\/g, '/')
        #     console.log 'ip', importPath
        #     "require '#{importPath}'"
        # .pipe concat 'app.entity.coffee'
        .pipe webpack webpackConfig
        .pipe gulp.dest path.join cfg.path.build, 'scripts'


module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
