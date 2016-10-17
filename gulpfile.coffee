cfg = require './$gulp/config'

require './$gulp/lib/global'
_       = require 'lodash'
fs      = require 'fs-extra'
path    = require 'path'

gulp    = require 'gulp'
webpack = require './$gulp/webpack'
bower   = require './$gulp/bower'
styl    = require './$gulp/stylus'
jade    = require './$gulp/jade'
assets  = require './$gulp/assets'

process.env.NODE_ENV = 'development' if !process.env.NODE_ENV

gulp.task 'clean', (cb) =>
    fs.ensureDirSync cfg.path.build
    fs.readdirSync(cfg.path.build).map (file) ->
        fs.removeSync path.join cfg.path.build, file
    cb()

gulp.task 'webpack', webpack
gulp.task 'bower', bower
gulp.task 'styl', styl
gulp.task 'jade', jade
gulp.task 'jade.index', jade.index
gulp.task 'assets', assets

gulp.task 'watch', ->
    gulp.watch webpack.watch,   gulp.series 'webpack', 'jade.index'
    gulp.watch bower.watch,  gulp.series 'bower', 'jade.index'
    gulp.watch styl.watch,   gulp.series 'styl', 'jade.index'
    gulp.watch jade.watch,   gulp.series 'jade', 'jade.index'
    gulp.watch assets.watch, gulp.series 'assets'

# --- server variants ---
gulp.task 'browser-sync', ->
    browserSync = require './$gulp/browser-sync'
    browserSync.watch path.join cfg.path.build, '**/*.*'
        .on 'change', browserSync.reload

gulp.task 'connect', ->
    connect = require './$gulp/connect'

gulp.task 'server', gulp.series 'browser-sync'
# ------

gulp.task 'build', gulp.series 'clean', gulp.parallel('webpack', 'bower', 'styl', 'jade', 'assets'), 'jade.index'
gulp.task 'default', gulp.series 'build', gulp.parallel('server', 'watch')
gulp.task 'demo', gulp.series 'build', 'connect'
