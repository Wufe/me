<?php
	/**
	 * Converts .js links to .min.js when in production.
	 */

	function minjs( $file ){
		if( config( 'app.env' ) !== "production" )
			return $file;
		return preg_replace( "#(.js)$#i", ".min.js", $file );
	}