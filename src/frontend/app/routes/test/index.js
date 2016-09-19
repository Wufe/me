import React, {Component, PropTypes} from 'react';

const Test = ({children}) => {
	return (
		<div>
			<span>Test Route</span>
		</div>
	);
};

Test.propTypes = {
	children: PropTypes.any
};

export default Test;