'use strict';
require('coffee-script/register');
var cfg = require('./$gulp/config');
const path = require('path');
const webpack = require('webpack');

console.log('wp cfg', __dirname);
module.exports = {
    // context: cfg.path.app,
    debug: true,
    watch: false,
    // entry: `${cfg.path.app}app/app.entry.coffee`,
    entry: {
        app: `${cfg.path.app}app/app.entry.coffee`
    },
    output: {
        // path: path.join(cfg.path.build, 'scripts'),
        filename: '[name].js',
        library: '[name]'
    },
    resolve: {
        // Tell webpack to look for required files in bower and node
        modulesDirectories: ['bower_components', 'node_modules'],
        extensions: ['', '.js', '.coffee', '.json']
    },
    resolveLoader: {
        modulesDirectories: ['node_modules'],
        extensions: ['', '.js']
    },
    module: {
        autoRequire: true, // custom option. See $gulp/webpack
        loaders: [
            //{ test: /\.js$/, loader: "babel-loader" },
            { test: /\.coffee$/, loader: "coffee-loader" },
            { test: /\.jade$/, loader: "jade-loader" }
        ],
        noParse: /\.min\.js$/
    },
    plugins: [
        new webpack.ResolverPlugin(
            new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin(".bower.json", ["main"])
        )
    ]
}
