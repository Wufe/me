var webpack = require( 'webpack' );
var path = require( 'path' );

var typescriptLoader = {
    test: /\.tsx?$/,
    exclude: /(node_modules|bower_components)/,
    loader: 'ts-loader'
};

module.exports = {
    context: path.join( __dirname, '..' ),
    devtool: "eval",
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
        filename: "javascript/[name].bundle.js",
        chunkFilename: 'javascript/[name].chunk.js'
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
                loader: 'url-loader?mimetype=image/jpeg&limit=100000&name=images/img-[name].[ext]' //use img-[hash].[ext] in production after a clean
            }
        ]
    },
    plugins: [],
    externals: {
        "react": "React",
        "react-dom": "ReactDOM"
    }
};