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

$data = json_encode([
	"quote" => Inspiring::quote(),
	"me"	=> [
		"name"		=> "Simone",
		"surname"	=> "Bembi"
	]
]);

$mainView = function() use ( $data ){
	return view('index', compact( "data" ));
};

Route::get('/', function () use ( $mainView ) {
    return $mainView();
});
Route::get('/test', function () use ( $mainView ) {
    return $mainView();
});
Auth::routes();

Route::get('/home', 'HomeController@index');

Auth::routes();

Route::get('/home', 'HomeController@index');
