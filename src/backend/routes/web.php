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

function mainView(){
	return view('index', [
    	"quote" => Inspiring::quote(),
    	"me"	=> [
    		"name"		=> "Piergiorgio",
    		"surname"	=> "Rabarbo"
    	]
    ]);
}

Route::get('/', function () {
    return mainView();
});
Route::get('/test', function () {
    return mainView();
});
Auth::routes();

Route::get('/home', 'HomeController@index');
