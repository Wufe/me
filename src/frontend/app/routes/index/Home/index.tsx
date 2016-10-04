declare let window: any;

import * as React from 'react';
import './home.scss';

interface Props{
	name: string;
	surname: string;
	quote: string;
}
interface State{}

export default class Home extends React.Component<Props, State>{
	render(){
		return (
			<div className="home-content" id="home">
				<nav className="navbar navbar-default">
					<div className="container-fluid">
						<div className="navbar-header">
							<button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
								<span className="sr-only">Toggle navigation</span>
								<span className="icon-bar"></span>
								<span className="icon-bar"></span>
								<span className="icon-bar"></span>
						    </button>
							<a href="/#home" className="navbar-brand">{window.blade.data.me.name || this.props.name} {window.blade.data.me.surname || this.props.surname}</a>
						</div>
						<div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul className="nav navbar-nav navbar-right">
								<li><a href="#skills">Skills</a></li>
								<li><a href="#experiences">Experiences</a></li>
								<li><a href="#works">Works</a></li>
								<li><a href="#contacts">Contacts</a></li>
							</ul>
						</div>
					</div>
				</nav>
				<div className="centered-content">
					<div className="centered-container">
						<div className="darker-content">
							<div className="centered-title">
								{window.blade.data.me.name || this.props.name} {window.blade.data.me.surname || this.props.surname}
							</div>
							<div className="centered-subtitle">
								{window.blade.data.quote || this.props.quote}
							</div>
						</div>
						<div className="centered-info">Site under construction</div>
					</div>
				</div>
			</div>
		);
	}
}