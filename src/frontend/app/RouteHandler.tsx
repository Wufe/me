import RouteLoader from './lib/RouteLoader';
import * as React from 'react';
import * as ReactRouter from 'react-router';
import App from './App';

class RouteHandler{

	constructor(){}

	loadComponent( route: string ){
		return ( nextState: ReactRouter.RouterState, callback: (error: any, component?: React.ReactType ) => void ) => {
			RouteLoader( nextState, callback, route );
		};
	}

	goTo( route: string ){
		ReactRouter.browserHistory.push( route );
	}

	getRoutes(){
		return (
			<ReactRouter.Route path="/" component={App}>
				<ReactRouter.IndexRoute getComponent={this.loadComponent( "index" )} />
				<ReactRouter.Route path="test" getComponent={this.loadComponent( "test" )} />
			</ReactRouter.Route>
		);
	}
}

const routeHandler: RouteHandler = new RouteHandler;
export default routeHandler;