cfg = require './config'

fs = require 'fs'
path = require 'path'
proxy = require 'http-proxy-middleware'
fallback = require 'connect-history-api-fallback'
connect = require 'gulp-connect'

middleware = []
if cfg.api.active then middleware.push proxy '/api', { target: "http://#{cfg.api.host}:#{cfg.api.port}" }
if cfg.webserver.fallback then middleware.push fallback()

server = connect.server
    root: cfg.path.build
    port: cfg.webserver.port
    livereload: false
    middleware: middleware

module.exports = server
