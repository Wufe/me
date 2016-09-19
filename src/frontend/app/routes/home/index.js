import React, {Component, PropTypes} from 'react';

const Home = ({children}) => {
	return (
		<div>
			<h2>THIS IS MY HOME</h2>
		</div>
	);
};

Home.propTypes = {
	children: PropTypes.any
};

export default Home;