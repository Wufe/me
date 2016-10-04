import * as React from 'react';
import * as ReactRouter from 'react-router';

declare let require: any;
export default ( nextState: ReactRouter.RouterState, callback: (error: any, component?: React.ReactType ) => void, name: string ) => {
	let moduleRequest: (module: any) => void;
	switch( name ){
		case "test":
			moduleRequest = require( "bundle?name=test.route!../routes/test/" );
			break;
		case "index":
			moduleRequest = require( "bundle?name=index.route!../routes/index/" );
			break;
	}
	moduleRequest( (module: any) => {
		callback( null, module.default );
	});
};