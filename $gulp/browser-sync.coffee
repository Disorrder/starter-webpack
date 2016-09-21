cfg = require './config'

fs = require 'fs'
path = require 'path'
proxy = require 'http-proxy-middleware'
fallback = require 'connect-history-api-fallback'
browserSync = require('browser-sync').create()

middleware = []
if cfg.api.active then middleware.push proxy '/api', { target: "http://#{cfg.api.host}:#{cfg.api.port}" }
if cfg.webserver.fallback then middleware.push fallback()

browserSync.init
    startPath: '/'
    server: cfg.path.build
    # server: false
    host: cfg.webserver.host
    port: cfg.webserver.port
    middleware: middleware

module.exports = browserSync
