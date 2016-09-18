export default ( location, callback, name ) => {
	let moduleRequest;
	switch( name ){
		case "test":
			moduleRequest = require( "bundle?name=test-route!../routes/test/Test" );
			break;
	}
	moduleRequest( module => {
		callback( null, module.default );
	});
};