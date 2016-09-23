import BabelRegister from 'babel-register';
import BabelPolyfill from 'babel-polyfill';
import express from 'express';
import BodyParser from 'body-parser';

let app = express();
let port = 1341;
app.use( BodyParser.urlencoded({
    extended: true
}));
app.use( BodyParser.json() );

(() => {
	app.post( `/webhook`, (req, res) => {
		console.log( "Post request body:" );
		console.log( req.body );
		res.send( "Received." );
	}).get( `/webhook`, (req, res) => {
		console.log( "Received a get request." );
		res.send( "Try with a post request" );
	})

	app.listen( port, '0.0.0.0', `Listening on port ${port}.` );
})();