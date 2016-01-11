<?php

class AuthController extends BaseController {

    public function login()
    {
        try{
            $user = Sentry::getUserProvider()->findByLogin(Input::json('email'));
            $throttle = Sentry::getThrottleProvider()->findByUserId($user->id);
            $throttle->setSuspensionTime(10);
            $throttle->setAttemptLimit(3);
            $throttle->check();
            $credentials = ['email' => Input::json('email'), 'password' => Input::json('password')];
            $user = Sentry::authenticate($credentials, false);
        } catch (Cartalyst\Sentry\Users\WrongPasswordException $e) {
            return Response::json(array('flash' => 'Invalid username or password'), 500);
        } catch (Cartalyst\Sentry\Users\LoginRequiredException $e) {
            return Response::json(array('flash' => 'Login field is required'), 500);
        } catch (Cartalyst\Sentry\Users\PasswordRequiredException $e) {
            return Response::json(array('flash' => 'Password field is required'), 500);
        } catch (Cartalyst\Sentry\Users\UserNotFoundException $e) {
            return Response::json(array('flash' => 'Invalid username or password'), 500);
        } catch (Cartalyst\Sentry\Users\UserNotActivatedException $e) {
            return Response::json(array('flash' => 'This account is inactive'), 500);
        } catch (Cartalyst\Sentry\Throttling\UserSuspendedException $e) {
            $time = $throttle->getSuspensionTime();
            return Response::json(array('flash' => 'This account is suspended for '.$time.' minutes'), 500);
        } catch (Cartalyst\Sentry\Throttling\UserBannedException $e) {
            return Response::json(array('flash' => 'This account has been banned'), 500);
        }

        $user_details = User::join('users_groups', 'users.id', '=', 'users_groups.user_id')
                        ->join('groups', 'users_groups.group_id', '=', 'groups.id')
                        ->where('users.id', '=', $user->id)
                        ->select('users.id', 'users.email', 'users.first_name', 'users.last_name', 'groups.name as role', 'users.activated_at','users.last_login', 'users.created_at', 'users.updated_at')
                        ->get();
        return Response::json($user_details[0], 200);
    }

    public function logout()
    {
        Sentry::logout();
        return Response::json(array('flash' => 'You\'ve logged out!'));
    }

    // Testing tokk
    public function status() {
        if(Sentry::check()) {
            return 'You are logged in, here are secrets.';
        } else {
            return 'You aint logged in, no secrets for you.';
        }
    }

}
