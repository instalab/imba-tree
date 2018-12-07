module.exports = {
	module: {
		rules: [
			{
				test: /\.imba$/,
				loader: 'imba/loader',
			},
			{
				test: /\.m?js$/,
				exclude: /(node_modules|bower_components)/,
				use: {
					loader: 'babel-loader',
					options: {
						presets: ['@babel/preset-env']
					}
				}
			}
		]
	},
	resolve: {
		extensions: [".imba",".js", ".json"]
	},
	entry: "./src/app.imba",
	output: {  path: __dirname + '/dist', filename: "app.js" }
}
