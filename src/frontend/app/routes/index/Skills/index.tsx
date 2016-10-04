declare let window: any;

import * as React from 'react';
import './skills.scss';

interface Props{}
interface State{}

export default class Skills extends React.Component<Props, State>{
	render(){
		return (
			<div className="skills-content" id="skills">
				These are my skills:
			</div>
		);
	}
}