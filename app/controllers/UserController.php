<?php

class UserController extends BaseController {

    public function __construct()
    {
        $this->beforeFilter('admin', array('except' => 'showMyLeads'));
    }

    public function store(){

        $v = Validator::make($data = Input::all(), User::$rules);

        if($v->fails())
        {
            return Response::json(array($v->errors()->toArray()), 500);
            // return Response::json(array('flash' => 'Something went wrong, try again !'), 500);
        }else{
            $user = Sentry::register(array(
                'email'    => Input::get('email'),
                'password' => Input::get('password'),
                'first_name' => Input::get('first_name'),
                'last_name' => Input::get('last_name')
            ), true);

            if (Input::hasFile('picture')) {
                $uploaded_picture = Input::file('picture');

                // mengambil extension file
                $extension = $uploaded_picture->getClientOriginalExtension();

                // membuat nama file random dengan extension
                $filename = md5(time()) . '.' . $extension;
                $destinationPath = public_path() . DIRECTORY_SEPARATOR . 'img/photos';

                // memindahkan file ke folder public/img/photos
                $uploaded_picture->move($destinationPath, $filename);

                // mengisi field picture di user dengan filename yang baru dibuat
                $user->picture = $filename;
                $user->save();
            }

            // Find the similiar group
            $GroupId = Sentry::findGroupById(Input::get('group_id'));

            // Insert user user into specified group
            $user->addGroup($GroupId);

            return Response::json(array('flash' => 'New user has been successfully created !'), 200);
        }
    }

    public function update($id){
        $user = User::findOrFail($id);
        $v = Validator::make($data = Input::except('id'), $user->updateRules());

        $currentUser = Sentry::getUser();
        if($id != 1 || ($id == 1 && $currentUser->id == 1)) {
            if($v->fails())
            {
                //return Response::json(array($v->errors()->toArray()), 500);
                return Response::json(array('flash' => 'Something went wrong, try again !'), 500);
            }else{
                $user->first_name = Input::get('first_name');
                $user->last_name = Input::get('last_name');
                $user->email = Input::get('email');
                $user->activated = Input::get('activated');

                if (Input::hasFile('picture')) {
                    $filename = null;
                    $uploaded_picture = Input::file('picture');
                    $extension = $uploaded_picture->getClientOriginalExtension();

                    // membuat nama file random dengan extension
                    $filename = md5(time()) . '.' . $extension;
                    $destinationPath = public_path() . DIRECTORY_SEPARATOR . 'img/photos';

                    // memindahkan file ke folder public/img
                    $uploaded_picture->move($destinationPath, $filename);

                    // hapus picture lama, jika ada
                    if ($user->picture) {
                        $old_picture = $user->picture;
                        $filepath = public_path() . DIRECTORY_SEPARATOR . 'img/photos'
                            . DIRECTORY_SEPARATOR . $user->picture;

                        try {
                            File::delete($filepath);
                        } catch (FileNotFoundException $e) {
                            // File sudah dihapus/tidak ada
                        }
                    }

                    // ganti field picture dengan picture yang baru
                    $user->picture = $filename;
                }

                $user->save();
                return Response::json(array('flash' => 'The user has been successfully updated !'), 200);
            }
        } else {
            return Response::json(array('flash' => 'ERROR 403 : You are prohibited to update this user !'), 403);
        }
    }

    public function destroy($id){
        if($id != 1) {
            $user = User::find($id);
            $user->leads()->detach();
            $user->delete();

            if ($user->picture) {
                $old_picture = $user->picture;
                $filepath = public_path() . DIRECTORY_SEPARATOR . 'img/photos'
                    . DIRECTORY_SEPARATOR . $user->picture;

                try {
                    File::delete($filepath);
                } catch (FileNotFoundException $e) {
                    // File sudah dihapus/tidak ada
                }
            }
            return Response::json(array('flash' => 'The user has successfully removed !'), 200);
        } else {
            return Response::json(array('flash' => 'ERROR 401 : You are not authorized to remove this user !'), 401);
        }
    }

    public function index(){
        return Response::json(User::with('groups')->get());
    }

    public function show($id){
        if($id != 1){
            $user = User::with('leads','groups')->findOrFail($id);
            return Response::json($user);
        } else {
            return Response::json(array('flash' => 'ERROR 401 : You are not authorized to access this page !'), 401);
        }
    }

    public function showMyLeads(){
        $user = Sentry::getUser();
        $showMyLeads = Lead::with('users')->get();
        return Response::json($showMyLeads, 200);
    }

    public function groupList(){
        $groups = Sentry::findAllGroups();
        return Response::json($groups, 200);
    }


}
