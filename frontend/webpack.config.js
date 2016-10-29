var path = require("path");
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ngAnnotatePlugin = require('ng-annotate-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');


var plugins = [
    new CopyWebpackPlugin([
        { from: './wwwsrc/static' , to: './'},
    ], {
        copyUnmodified: true
    }),
    new HtmlWebpackPlugin({
        template: './wwwsrc/index.html',
        inject: false
    }),
    new ngAnnotatePlugin({
        add: true
    })
];

module.exports = {
	devServer:{
		host: "0.0.0.0"	,
  		historyApiFallback: true,
		outputPath: path.join(__dirname, 'www')
	},
	resolve: {
		alias: {
			config: path.join(__dirname, 'config', process.env.ENV + ".js")
		}
	},
	module: {
        preLoaders: [],
		postLoaders: [],
		loaders: [
			{
				test: /\.js$/,
				include: [
					path.resolve(__dirname, 'wwwsrc')
				],
				loader: 'babel', // 'babel-loader' is also a legal name to reference
				query: {
					presets: ['es2015']
				}
			},
        	{
				test: /\.json$/, 
				include: [
					path.resolve(__dirname, 'wwwsrc'),
					path.resolve(__dirname, 'node_modules/moment-timezone/data/packed/'),
					path.resolve(__dirname, 'node_modules/constants-browserify/')
				],
				loaders: ["json-loader"]
			},
			{
				test: /\.scss$/,
				include: [
					path.resolve(__dirname, 'wwwsrc'),
					path.resolve(__dirname, 'node_modules/angular-material/')
				],
				loader: 'style-loader!css-loader!autoprefixer-loader!resolve-url-loader!sass-loader'
			},
			{
				test: /\.css$/,
				include: [
					path.resolve(__dirname, 'wwwsrc'),
					path.resolve(__dirname, 'node_modules/angularjs-slider/')
				],
				loader: 'style-loader!css-loader!autoprefixer-loader'
			},
			{
				test: /\.html$/,
				include: [
					path.resolve(__dirname, 'wwwsrc')
				],
				loader: "html"
			},
			{ 
				test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, 
				include: [
					path.resolve(__dirname, 'wwwsrc')
				],
				loader: "url-loader?limit=10000&minetype=application/font-woff" 
			},
      		{ 
				test: /\.(ttf|eot|gif|svg|png|jpg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, 
				include: [
					path.resolve(__dirname, 'wwwsrc')
				],
				loader: "file-loader" 
			}
		]
	},
	entry: {
		app: ["./wwwsrc/app.js"]
	},
	output: {
        path: __dirname + "/www/",
		filename: "bundle.js"
	},
    plugins,
    resolveLoader: { root: path.join(__dirname, "node_modules") }
}