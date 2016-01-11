<?php

class Leadstatus extends Eloquent {

    protected $table = "lead_statuses";

    public $timestamps = false;

    public function leads(){
        return $this->hasMany('Lead');
    }

}
