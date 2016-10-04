import * as React from 'react';
import './assets/styles/app.scss';

export interface AppProps {
	children: any;
}

class App extends React.Component<AppProps, {}>{
	render(){
		return (
			<div>
				{this.props.children}
			</div>
		);
	}
}

export default App;