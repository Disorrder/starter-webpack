'use strict';
var cfg = require('./$gulp/config');
const path = require('path');

module.exports = {
    target: 'web',
    debug: true,
    watch: false,
    entry: path.join(cfg.path.app, 'app/Application.coffee'),
    output: {
        path: path.join(cfg.path.build, 'scripts'),
        file: 'bundle.js'
    },
    resolve: {
        // Tell webpack to look for required files in bower and node
        modulesDirectories: ['bower_components', 'node_modules'],
        extensions: ['', '.js', '.json']
    },
    module: {
        loaders: [
          //{ test: /\.js$/, loader: "babel-loader" },
          { test: /\.coffee$/, loader: "coffee-loader" }
        ],
        noParse: /\.min\.js$/
    }
}
