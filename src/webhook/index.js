import BabelRegister from 'babel-register';
import BabelPolyfill from 'babel-polyfill';
import express from 'express';
import BodyParser from 'body-parser';
import xhub from 'express-x-hub';

let app = express();
let port = 1341;
app.use( BodyParser.urlencoded({
    extended: true
}));
app.use( BodyParser.json() );

let secret = process.env.WEBHOOK_SECRET;
app.use( xhub({
	algorithm: 'sha1',
	secret
}));

(() => {
	app.post( `/webhook`, (req, res) => {
		console.log( "Post request body:" );
		console.log( req.body );
		if( req.isXHub && req.isXHubValid() ){
			res.send( "Received." );
			console.log( "Acceptable." );
		}else{
			res.send( "Rejected." );
			console.log( "Wrong secret." );
		}
	}).get( `/webhook`, (req, res) => {
		console.log( "Received a get request." );
		res.send( "Try with a post request" );
	})

	app.listen( port, '0.0.0.0', `Listening on port ${port}.` );
})();