<?php

use Carbon\Carbon;

class Lead extends Eloquent {

    protected $table = "leads";

    public static $rules = [
        'salutation'       => 'max:7',
        'first_name'       => 'required|alpha_space|max:50|',
        'last_name'        => 'alpha_space|max:50',
        'phone'            => 'regex:/[0-9]{6,15}/',
        'email'            => 'email|max:50',
        'address'          => 'required|max:255',
        'address2'         => 'max:255',
        'instance'         => 'max:75',
        'status_id'        => 'required|exists:lead_statuses,id',
        'description'      => 'max:255'
    ];

    protected $fillable = ['salutation', 'first_name', 'last_name', 'phone', 'email', 'address', 'address2', 'instance', 'status_id', 'description'];

    public function leadstatus(){
        return $this->belongsTo('Leadstatus', 'status_id');
    }

    public function users(){
        return $this->belongsToMany('User', 'logs_leads', 'lead_id', 'user_id')->withPivot('notes')->withTimestamps();
    }

    public function getCreatedAtAttribute($attr) {
        return Carbon::parse($attr)->format('d-m-Y H:i'); //Change the format to whichever you desire
    }

    public function getUpdatedAtAttribute($attr) {
        return Carbon::parse($attr)->format('d-m-Y H:i'); //Change the format to whichever you desire
    }
}
