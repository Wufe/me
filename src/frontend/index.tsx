import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { Router, browserHistory } from 'react-router';
import Store from './app/Store';
import RouteHandler from './app/RouteHandler';

ReactDOM.render(
	<Provider store={Store.getStore()}>
		<Router history={browserHistory} routes={RouteHandler.getRoutes()} />
	</Provider>,
    document.getElementById( "app" )
);