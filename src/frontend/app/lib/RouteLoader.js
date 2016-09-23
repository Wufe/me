export default ( location, callback, name ) => {
	let moduleRequest;
	switch( name ){
		case "test":
			moduleRequest = require( "bundle?name=test.route!../routes/test/" );
			break;
		case "index":
			moduleRequest = require( "bundle?name=index.route!../routes/index/" );
			break;
	}
	moduleRequest( module => {
		callback( null, module.default );
	});
};