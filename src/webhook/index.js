import BabelRegister from 'babel-register';
import BabelPolyfill from 'babel-polyfill';
import express from 'express';
import BodyParser from 'body-parser';
import xhub from 'express-x-hub';
import {exec, spawn} from 'child_process';

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
		//console.log( "Post request body:" );
		//console.log( req.body );
		console.log( "Got a request." );
		let args = [
            "pull"
        ];
        let cmd = spawn( "git", args );
        cmd.stdout.on( 'data', ( data ) => {
            console.log( data.toString() );
        });
        cmd.stderr.on( 'data', ( data ) => {
        });
        cmd.on( 'error', ( err ) => {
            console.log( err );
            console.log( "Cannot pull." );
        });
        cmd.on( 'close', ( code ) => {
            
            if( req.body.head_commit.message.match( /Production\./ ) ){
                console.log( "Requires a production elaboration: compiling.." );
                cmd = spawn( "make", [ "production" ]);
                cmd.stdout.on( 'data', ( data ) => {
                    //console.log( data.toString() );
                });
                cmd.stderr.on( 'data', ( data ) => {
                    //console.log( data.toString() );
                });
                cmd.on( 'error', ( err ) => {
                    //console.log( err );
                });
                cmd.on( 'close', ( code ) => {
                    console.log( "Done refactoring." );
                });
            }else{
                console.log( "Pulled." );
            }
        });
		res.send( "OK" );
	}).get( `/webhook`, (req, res) => {
		console.log( "Received a get request." );
		res.send( "Try with a post request" );
	})

	app.listen( port, '0.0.0.0', `Listening on port ${port}.` );
})();