import React from 'react';

class App extends React.Component{
	render(){
		return (
			<div className="mainApp">
				yo! I'm in the main app class.
				<br />
				{ this.props.children || "Main Route" }
			</div>
		);
	}
}

App.propTypes = {
	children: React.PropTypes.any
};

export default App;