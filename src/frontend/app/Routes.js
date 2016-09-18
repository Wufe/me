import React from 'react';
import { Route, IndexRoute, browserHistory } from 'react-router';

import RouteLoader from './lib/RouteLoader';

import App from './App';

class Routes{

	constructor(){}

	loadComponent = route => {
		return ( location, callback ) => {
			RouteLoader( location, callback, route );
		};
	}

	goTo = route => {
		browserHistory.push( route );
	}

	getRoutes(){
		return (
			<Route path="/" component={App}>
				<Route path="test" getComponent={this.loadComponent( "test" )}>
				</Route>
            </Route>
		);
	}
}

const routes = new Routes;

export default routes;
