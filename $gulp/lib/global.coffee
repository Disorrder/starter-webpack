cfg = require '../config'
_ = require 'lodash'
path = require 'path'
gulp = require 'gulp'
util = require 'gulp-util'
ignore = require 'gulp-ignore'
notify = require 'gulp-notify'

global.getSources = (glob) ->
    # if !_.isArray glob then glob = [glob]
    # glob = glob.map (mask) -> path.join cfg.path.app, mask

    glob = path.join cfg.path.app, glob
    gulp.src glob, {base: cfg.path.app}
        .pipe ignore.exclude "**/#{cfg.excludePrefix}*" # excludes files
        .pipe ignore.exclude "**/#{cfg.excludePrefix}*/**/*" # and folders
        .pipe ignore.exclude cfg.ignore

global.errorHndl = (e) ->
    # new util.PluginError 'compile', e, {showStack: true}
    notify.onError({
        onLast: true
    })(e)

global.runIfProd = (cb) ->
    if util.env.production then cb() else util.noop()
