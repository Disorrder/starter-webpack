cfg = require './config'

fs = require 'fs'
path = require 'path'
gulp = require 'gulp'
util = require 'gulp-util'
webpack = require 'webpack-stream'
webpackConfig = require '../webpack.config.js'
files = require './lib/build'

glob = '**/*.coffee'
compile = (cb) ->
    # if webpackConfig.module.autoRequire
    #     entryFile = path.join cfg.path.app, 'app/app.entry.coffee'
    #     scripts = files.getByGlob [glob, '!**/*.entry.coffee' ], path.join cfg.path.app, 'app'
    #     scripts = scripts.map (v) ->
    #         "require '.#{v}'"
    #     scripts = scripts.join '\n'
    #
    #     oldScripts = fs.readFileSync entryFile
    # 
    #     if scripts != oldScripts.toString()
    #         fs.writeFileSync entryFile, scripts

    getSources 'config.js' # TODO: into another task!
        .pipe gulp.dest cfg.path.build

    getSources '**/*.entry.coffee'
        .pipe webpack webpackConfig
        .pipe gulp.dest path.join cfg.path.build, 'scripts'

module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
