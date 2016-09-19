var webpack = require( 'webpack' );
var path = require( 'path' );
var debug = true;

module.exports = {
    context: path.join( __dirname, '..', '..' ),
    devtool: "inline-sourcemap", // null if not in debug
    entry: {
        main: "./src/frontend/index.js",
        vendor: [ 'react', 'react-dom', 'react-router', 'moment', 'jquery' ]
    },
    output: {
        publicPath: "/",
        path: path.join( 'src', 'backend', 'resources', 'assets' ),
        filename: "javascript/[name].bundle.js",
        chunkFilename: 'javascript/[name].chunk.js'
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
            },
            {
                test: /\.jpg$/,
                loader: 'url-loader?mimetype=image/jpeg&limit=100000&name=images/img-[name].[ext]' //use img-[hash].[ext] in production after a clean
            }
        ]
    },
    plugins: [
        // new webpack.optimize.DedupePlugin(),
        // new webpack.optimize.OccurenceOrderPlugin(),
        // new webpack.optimize.UglifyJsPlugin({ mangle: false, sourcemap: true })
    ]
}
