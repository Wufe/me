import * as React from 'react';

interface Props{
	children: any;
}

interface State{}

export default class Test extends React.Component<Props, State>{
	render(){
		return (
			<div>
				<span>Test Route</span>
			</div>
		);	
	}
}