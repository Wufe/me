import * as actionTypes from '../actions/actionTypes';
import initialState from './state/initialState';

export default (( state = initialState.test, action ) => {
	switch( action.type ){
		case actionTypes.TEST_ACTION:
			return Object.assign({}, state, { test: 'fired' });
		default:
			return state;
	}
});