<?php

/*
|--------------------------------------------------------------------------
| Application & Route Filters
|--------------------------------------------------------------------------
|
| Below you will find the "before" and "after" events for the application
| which may be used to do any work before or after a request into your
| application. Here you may also register your custom route filters.
|
*/

App::before(function($request)
{
	//
});


App::after(function($request, $response)
{
	//
});

/*
|--------------------------------------------------------------------------
| Authentication Filters
|--------------------------------------------------------------------------
|
| The following filters are used to verify that the user of the current
| session is logged into this application. The "basic" filter easily
| integrates HTTP Basic authentication for quick, simple checking.
|
*/

 /*$user = Sentry::getUser();
    // Cari grup admin
    $admin = Sentry::findGroupByName('admin');
    if (!$user->inGroup($admin)) {
        return Redirect::to('dashboard')->with("errorMessage", "Ooopppsss... Anda tidak tidak diizinkan untuk mengakses halaman itu.");
    }*/

Route::filter('admin', function(){
    $user = Sentry::getUser();
    $admin = Sentry::findGroupByName('administrator');
    if (!$user->inGroup($admin)) {
        return Response::json(array('error' => true,'flash' => 'ERROR 401 : You are not authorized to access this page !'), 401);
    }
});

Route::filter('salesman', function(){
    $user = Sentry::getUser();
    $salesman = Sentry::findGroupByName('salesman');
    if (!$user->inGroup($salesman)) {
        return Response::json(array('flash' => 'ERROR 401 : You are not authorized to access this page !'), 401);
    }
});

Route::filter('direktur', function(){
    $user = Sentry::getUser();
    $direktur = Sentry::findGroupByName('direktur');
    if (!$user->inGroup($direktur)) {
        return Response::json(array('flash' => 'ERROR 401 : You are not authorized to access this page !'), 401);
    }
});

Route::filter('auth', function()
{
	if (!Sentry::check())
    {
        return Response::json(array('flash' => 'Please log in to continue !'), 401);
    }
});


Route::filter('auth.basic', function()
{
	return Auth::basic();
});

/*
|--------------------------------------------------------------------------
| Guest Filter
|--------------------------------------------------------------------------
|
| The "guest" filter is the counterpart of the authentication filters as
| it simply checks that the current user is not logged in. A redirect
| response will be issued if they are, which you may freely change.
|
*/

Route::filter('guest', function()
{
	if (Auth::check()) return Redirect::to('/');
});

/*
|--------------------------------------------------------------------------
| CSRF Protection Filter
|--------------------------------------------------------------------------
|
| The CSRF filter is responsible for protecting your application against
| cross-site request forgery attacks. If this special token in a user
| session does not match the one given in this request, we'll bail.
|
*/
Route::filter('csrf_json', function()
{
    if (Session::token() !== Input::json('csrf_token'))
    {
        throw new Illuminate\Session\TokenMismatchException;
    }
});


Route::filter('csrf', function()
{
	if (Session::token() !== Input::get('_token'))
	{
		throw new Illuminate\Session\TokenMismatchException;
	}
});
