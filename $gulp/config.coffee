cfg         = require '../gulpconfig.json' # think about detect work directory
_           = require 'lodash'

defaultCfg = {
    "path": {
        "bower": "./",
        "app": "./src/",
        "build": "./.build/"
    },
    "filters": { # legacy
        "scripts": "**/*.js",
        "styles": "**/*.styl",
        "templates": "**/*.jade",
        # "index": "index.jade",
        "assets": "assets/**/*",
        "images": "**/*.{png,svg,gif,jpg,jpeg,ico}",
        "fonts": "**/*.{eot,svg,ttf,woff,woff2}"
    },
    "excludePrefix": "__",
    "notify": true,
    "usemin": true, # not implemented
    "hashLength": 6, # not implemented, may be rename
    "webpack": false, # not implemented
    "webserver": {
        "active": true,
        "https": false,
        "hostname": "localhost",
        "host": "0.0.0.0",
        "port": 1000,
        "open": true,
        "livereload": true,
        "fallback": true
    },
    "api": {
        "active": true,
        "https": false,
        "hostname": "localhost",
        "host": "localhost",
        "port": 2000
    },
    "ignore": [
        "**/mixins/**/*.{jade,styl}",
        "**/*.mixin.{jade,styl}"
    ],
    "version": "0.0.0"
}

config = _.extend({}, defaultCfg, cfg) if !config

if process.env.HOST then config.webserver.host = process.env.HOST
if process.env.PORT then config.webserver.port = process.env.PORT

module.exports = config
