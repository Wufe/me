import * as actionTypes from '../actions/actionTypes';
import initialState from './state/initialState';

declare let require: any;
const Assign = require( 'object-assign' );

export default (( state: any = initialState.test, action: any ) => {
	switch( action.type ){
		case actionTypes.TEST_ACTION:
			return Assign({}, state, { test: 'fired' });
		default:
			return state;
	}
});