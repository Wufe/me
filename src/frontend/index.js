import Moment from 'moment';
import React from 'react';
import ReactDOM from 'react-dom';
import { Router, browserHistory } from 'react-router';
import {Provider} from 'react-redux';
import Routes from './app/Routes';
import Store from './app/Store';

Moment.locale( "it" );

ReactDOM.render(
	(
		<Provider store={Store.getStore()}>
			<Router history={browserHistory} routes={Routes.getRoutes()} />
		</Provider>
	),
	document.getElementById( "app" )
);

console.log( `yo` );