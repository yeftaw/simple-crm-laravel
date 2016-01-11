<?php

class SentrySeeder extends Seeder
{
    public function run()
    {
        DB::table('users_groups')->delete();
        DB::table('groups')->delete();
        DB::table('users')->delete();
        DB::table('throttle')->delete();

        try
        {
            // create grup admin
            $group = Sentry::createGroup(array(
                'name'          => 'admin',
                'permissions'   => array(
                    'admin' => 1,
                )
            ));

            // create grup sales
            $group = Sentry::createGroup(array(
                'name'          => 'salesman',
                'permissions'   => array(
                    'sales' => 1,
                )
            ));

        }
        catch (Cartalyst\Sentry\Groups\NameRequiredException $e)
        {
            echo 'Name field is required';
        }
        catch (Cartalyst\Sentry\Groups\GroupExistsException $e)
        {
            echo 'Group already exists';
        }

        try
        {
            /*
             ** Admininistrator
             **
             */
            $admin = Sentry::register(array(
                'email' => 'admin@example.com',
                'password' => 'admin',
                'first_name' => 'Super',
                'last_name' => 'Administrator'
            ), true);

            $adminGroup = Sentry::findGroupByName('admin');

            // Masukkan user ke grup admin
            $admin->addGroup($adminGroup);

            /*
            ** Salesman
            **
             */
            $user = Sentry::register(array(
                'email' => 'salesman@example.com',
                'password' => 'salesman',
                'first_name' => 'Yefta',
                'last_name' => 'Aditya Wibowo'
            ), true);

            // Cari grup salesman
            $salesmanGroup = Sentry::findGroupByName('salesman');

            // Masukkan user ke grup salesman
            $user->addGroup($salesmanGroup);

        }
        catch (Cartalyst\Sentry\Users\LoginRequiredException $e)
        {
            echo 'Login field is required.';
        }
        catch (Cartalyst\Sentry\Users\PasswordRequiredException $e)
        {
            echo 'Password field is required.';
        }
        catch (Cartalyst\Sentry\Users\UserExistsException $e)
        {
            echo 'User with this login already exists.';
        }
        catch (Cartalyst\Sentry\Groups\GroupNotFoundException $e)
        {
            echo 'Group was not found.';
        }
    }
}
