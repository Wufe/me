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
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
						    </button>
							<a href="/" className="navbar-brand">{window.blade.data.me.name || data.me.name} {window.blade.data.me.surname || data.me.surname}</a>
						</div>
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul className="nav navbar-nav navbar-right">
								<li><a href="/">Skills</a></li>
								<li><a href="/">Experiences</a></li>
								<li><a href="/">Works</a></li>
								<li><a href="/">Contacts</a></li>
							</ul>
						</div>
					</div>
				</nav>
				<div className="centered-content">
					
					<div className="centered-container">
						<div className="darker-content">
							<div className="centered-title">
								{window.blade.data.me.name} {window.blade.data.me.surname}
							</div>
							<div className="centered-subtitle">
								{window.blade.data.quote}
							</div>
						</div>
						<div className="centered-info">Site under construction</div>
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