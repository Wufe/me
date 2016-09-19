export default ( location, callback, name ) => {
	let moduleRequest;
	switch( name ){
		case "test":
			moduleRequest = require( "bundle?name=test.route!../routes/test/" );
			break;
		case "home":
			moduleRequest = require( "bundle?name=home.route!../routes/home/" );
			break;
	}
	moduleRequest( module => {
		callback( null, module.default );
	});
};