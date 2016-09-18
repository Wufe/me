import {createStore, applyMiddleware, compose} from 'redux';
import rootReducer from './reducers';
import reduxImmutableStateInvariant from 'redux-immutable-state-invariant';
import thunk from 'redux-thunk';
import ReduxLogger from 'redux-logger';

class Store{
	constructor( initialState ){
		this.store = createStore(
			rootReducer,
			initialState,
			compose(
				applyMiddleware( thunk, reduxImmutableStateInvariant(), ReduxLogger() ),
				window.devToolsExtension ? window.devToolsExtension() : f => f
			)
		);
	}

	getStore(){
		return this.store;
	}
}

const store = new Store;

export default store;