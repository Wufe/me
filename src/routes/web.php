<?php

use Illuminate\Foundation\Inspiring;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

Route::get('/', function () {
	$data = json_encode([
		"quote" => Inspiring::quote(),
		"me" 	=> [
			"name"	=> "Simone",
			"surname" => "Bembi"
		]
	]);
    return view( 'index', compact( 'data' ) );
});
