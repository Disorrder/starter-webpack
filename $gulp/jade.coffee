cfg = require './config'

_ = require 'lodash'
fs = require 'fs'
path = require 'path'
gulp = require 'gulp'
jade = require 'gulp-jade'
change = require 'gulp-change'
merge = require 'merge-stream'
files = require './lib/build'

glob = '**/*.jade'
compile = (locals = {}) ->
    getSources '*/' + glob
        .pipe jade
            pretty: true
        .on 'error', errorHndl
        .pipe gulp.dest cfg.path.build

params =
    cwd: cfg.path.app
    base: cfg.path.app
index = () ->
    streams = merge()
    # scriptsGlob = ['config.js', 'scripts/vendor.js', 'scripts/app.js', 'app/**/*.module.js', 'app/**/*.js']

    scripts = files.getByGlob ['config*.js', 'scripts/vendor*.js', 'scripts/*.js', 'app/**/*.js']
    styles  = files.getByGlob ['styles/vendor*.css', 'bower_components/**/*.css', 'styles/app*.css', 'app/**/*.css']

    # --- .build/index-attachments.jade ---
    # indexAttachments = ->
    #     content = ""
    #     content += "mixin styles()\n"
    #     styles.forEach (style) ->
    #         content += "    link(rel='stylesheet', href='#{style}')\n"
    #
    #     content += "mixin scripts()\n"
    #     scripts.forEach (script) ->
    #         content += "    script(src='#{script}')\n"
    #
    #     return content
    #
    # fs.writeFileSync path.join(cfg.path.build, 'index-attachments.jade'), indexAttachments()
    # ------

    # --- .build/index-locals.json ---
    fs.writeFileSync path.join(cfg.path.build, 'index-locals.json'), JSON.stringify { scripts, styles }, null, 4

    streams.add gulp.src('index.jade', params)
        .pipe jade
            pretty: true
            locals:
                scripts: scripts
                styles: styles
        .pipe gulp.dest cfg.path.build

    return streams

module.exports = compile
module.exports.index = index
module.exports.watch = path.join cfg.path.app, glob
