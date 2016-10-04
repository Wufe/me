declare const require: any;
declare const window: any;

import * as Redux from 'redux';
import rootReducer from './reducers';
import thunk from 'redux-thunk';
import reduxImmutableStateInvariant = require( 'redux-immutable-state-invariant' );
import ReduxLogger = require( 'redux-logger' );



class Store{

	store: Redux.Store<any>;

	constructor( initialState?: any ){
		this.store = Redux.createStore(
			rootReducer,
			initialState,
			Redux.compose(
				Redux.applyMiddleware( thunk, reduxImmutableStateInvariant(), ReduxLogger() ),
				window.devToolsExtension ? window.devToolsExtension() : f => f
			)
		);
	}

	getStore(){
		return this.store;
	}
}

const store: Store = new Store;
export default store;