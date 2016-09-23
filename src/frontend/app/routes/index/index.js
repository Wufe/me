import React, {Component, PropTypes} from 'react';
import Style from '../../../assets/style/index.scss';
import Home from './Home';
import Skills from './Skills';

const Index = ({children}) => {
	let data = {
		me: {
			name: "Simone",
			surname: "Bembi"
		},
		quote: "",
		links: []
	};

	let links = [];
	if( window.blade && window.blade.data && window.blade.data.links )
		links = window.blade.data.links;
	return (
		<div id="index">
			<div className="background-image"></div>
			<div className="background-image-overlay"></div>
			<div className="index-content">
				<Home />
				<Skills />
			</div>
			
		</div>
	);
};

Index.propTypes = {
	children: PropTypes.any
};

export default Index;