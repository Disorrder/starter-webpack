cfg = require './config'

path = require 'path'
gulp = require 'gulp'
webpack = require 'webpack'
webpackConfig = '../webpack.config.coffee'

glob = ['**/*.coffee']
compile = ->


module.exports = compile
module.exports.watch = path.join cfg.path.app, glob
