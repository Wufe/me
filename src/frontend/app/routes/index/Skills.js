import React, {Component, PropTypes} from 'react';
import Style from '../../../assets/style/skills.scss';

const Skills = ({children}) => {
	return (
		<div className="skills-content" id="skills">
			These are my skills:
		</div>
	);
};

Skills.propTypes = {
	children: PropTypes.any
};

export default Skills;