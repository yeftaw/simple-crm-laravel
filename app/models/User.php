<?php
use Cartalyst\Sentry\Users\Eloquent\User as Sentry;
use Carbon\Carbon;

class User extends Sentry {

    public function updateRules()
    {
        $rules = static::$rules;
        foreach ($rules as $field => $rule) {
            // replace {ignore_id} with $model->id
            $rules[$field] = str_replace('{ignore_id}', $this->getKey(), $rule);
        }
        unset($rules['password']);
        unset($rules['group_id']);
        $rules['activated'] = 'required|boolean';
        return $rules;
    }

    protected $table = 'users';

    public static $rules = [
        'first_name' => 'required|alpha_space|max:75',
        'last_name'  => 'alpha_space|max:75',
        'email'      => 'required|email|max:75|unique:users,email,{ignore_id}',
        'password'   => 'confirmed|required|min:5',
        'group_id'   => 'required|numeric|exists:groups,id',
        'picture'    => 'image|max:2048'
    ];

    protected $fillable = ['first_name', 'last_name', 'email', 'password', 'activated', 'group_id'];

    public function leads(){
        return $this->belongsToMany('Lead', 'logs_leads')->withPivot('notes')->withTimestamps();
    }

    public function getCreatedAtAttribute($attr) {
        return Carbon::parse($attr)->format('d-m-Y H:i'); //Change the format to whichever you desire
    }

    public function getUpdatedAtAttribute($attr) {
        return Carbon::parse($attr)->format('d-m-Y H:i'); //Change the format to whichever you desire
    }

}
