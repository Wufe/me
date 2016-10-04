var webpack = require( 'webpack' );
var path = require( 'path' );

var typescriptLoader = {
    test: /\.tsx?$/,
    exclude: /(node_modules|bower_components)/,
    loader: 'ts-loader'
};

module.exports = {
    context: path.join( __dirname, '..' ),
    devtool: "null",
    resolve: {
        extensions: [ "", ".webpack.js", ".web.js", ".ts", ".tsx", ".js" ]
    },
    entry: {
        main: "./src/frontend/index.tsx",
        vendor: []
    },
    output: {
        publicPath: "/",
        path: path.join( 'src', 'resources', 'assets' ),
        filename: "javascript/[name].bundle.min.js",
        chunkFilename: 'javascript/[name].chunk.min.js'
    },
    target: 'web',
    module: {
        loaders: [
            typescriptLoader,
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
                loader: 'url-loader?mimetype=image/jpeg&limit=100000&name=images/img-[hash].[ext]' //use img-[hash].[ext] in production after a clean
            }
        ]
    },
    plugins: [
        new webpack.optimize.DedupePlugin(),
        new webpack.optimize.OccurenceOrderPlugin(),
        new webpack.optimize.UglifyJsPlugin({
            debug: false,
            minimize: true,
            sourceMap: false,
            output: {
                comments: false
            },
            compressor: {
                warnings: false
            },
            mangle: false
        }),
        new webpack.DefinePlugin({
            'process.env': {
                'NODE_ENV': JSON.stringify( 'production' )
            }
        })
    ],
    externals: {
        "react": "React",
        "react-dom": "ReactDOM"
    }
};