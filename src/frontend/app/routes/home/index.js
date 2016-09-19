import React, {Component, PropTypes} from 'react';
import Style from '../../../assets/style/home.scss';

const Home = ({children}) => {
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
		<div id="home">
			<div className="background-image"></div>
			<div className="background-image-overlay"></div>
			<div className="home-content">
				<nav className="navbar navbar-default">
					<div className="container-fluid">
						<div className="navbar-header">
							<a href="/" className="navbar-brand">{window.blade.data.me.name || data.me.name} {window.blade.data.me.surname || data.me.surname}</a>
							<div className="top-right links">
								<a href="/">Skills</a>
								<a href="/">Experiences</a>
								<a href="/">Works</a>
								<a href="/">Contacts</a>
								{links.map(url => <a key={url[0]} href={url[1]}>{url[0]}</a>)}
							</div>
						</div>
					</div>
				</nav>
				<div className="centered-content">
					<div className="centered-container">
						<div className="centered-title">
							{window.blade.data.me.name} {window.blade.data.me.surname}
						</div>
						<div className="centered-subtitle">
							{window.blade.data.quote}
						</div>
					</div>
				</div>
			</div>
		</div>
	);
};

Home.propTypes = {
	children: PropTypes.any
};

export default Home;