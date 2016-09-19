import React from 'react';
import Style from '../assets/style/main.scss';

class App extends React.Component{
	render(){
		return (
			<div class="mainApp">
				{ this.props.children || "Main Route" }
			</div>
		);
	}
}

App.propTypes = {
	children: React.PropTypes.any
};

export default App;