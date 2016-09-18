var webpack = require( 'webpack' );
var path = require( 'path' );
var debug = true;

module.exports = {
    context: path.join( __dirname, '..' ),
    devtool: "inline-sourcemap" : null,
    entry: {
        main: "./src/index.js",
        vendor: [ 'react', 'react-dom', 'react-router', 'radium', 'moment', 'jquery' ]
    },
    output: {
        publicPath: "/assets/javascript/",
        path: path.join( __dirname, '..', 'backend', 'public', 'assets', 'javascript' ), //__dirname + "/../Server/public/assets/javascript",
        filename: "[name].bundle.js",
        chunkFilename: '[name]-chunk.js'
    },
    target: 'web',
    module: {
        loaders: [
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,
                loader: 'babel-loader',
                query: {
                    presets: [ 'react', 'es2015', 'stage-0' ],
                    plugins: [ 'react-html-attrs', 'transform-class-properties', 'transform-decorators-legacy' ]
                }
            },
            {
                test: /\.css$/,
                loader: 'style!css!'
            },
            {
                test: /\.scss$/,
                loader: 'style!css!sass!'
            }
        ]
    },
    plugins: debug ? [
        //new webpack.optimize.CommonsChunkPlugin( "signup-route.bundle.js", ["signup-component", "main"])
    ] : [
        new webpack.optimize.DedupePlugin(),
        new webpack.optimize.OccurenceOrderPlugin(),
        new webpack.optimize.UglifyJsPlugin({ mangle: false, sourcemap: true })
    ]
}
