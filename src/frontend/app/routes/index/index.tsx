import * as React from 'react';
import './index.scss';

import Home from './Home';
import Skills from './Skills';

interface Props{
	children: any;
}
interface State{}

export default class Index extends React.Component<Props, State>{


	data = {
		me: {
			name: "Simone",
			surname: "Bembi"
		},
		quote: ""
	};

	render(){
		return (
			<div id="index">
				<div className="background-image"></div>
				<div className="background-image-overlay"></div>
				<div className="index-content">
					<Home name={this.data.me.name} surname={this.data.me.surname} quote={this.data.quote}/>
					<Skills />
				</div>
			</div>
		);	
	}
}