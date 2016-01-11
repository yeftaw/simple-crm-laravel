<?php

Route::get('/', function(){
    return View::make('index');
});

// API
Route::group(array('prefix' => 'api'),function() {
    Route::group(array('before' => 'auth'), function() {
        Route::resource('leads', 'LeadController');
        Route::resource('users', 'UserController');
        Route::get('userGroupList', 'UserController@groupList');
        Route::get('leadstatuses', 'LeadController@leadstatuses');
        Route::get('showMyLeads', 'UserController@showMyLeads');

        // GRAFIK
        Route::get('/leadsPerMonth', 'LeadController@leadsPerMonth');
        Route::get('/leadsByUsers', 'LeadController@leadsByUsers');
        Route::get('/leadsByUser', 'LeadController@leadsByUser');
    });

    // LOGIN
    Route::group(array('prefix' => 'auth'),function() {
        Route::post('login', array('before' => 'csrf_json', 'uses' => 'AuthController@login'));
        Route::get('logout', 'AuthController@logout');
    });
});

App::missing(function($exception) {
    return Redirect::to('/');
});
// TES
Route::get('/status', 'AuthController@status');
Route::get('/cek', 'LeadController@leadsPerMonth');

