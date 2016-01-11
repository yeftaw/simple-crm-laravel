<?php namespace YevtAw\Leads;

use Redis;
use Response;

class LeadUpdatedEventHandler {

    CONST EVENT = 'leads.update';
    CONST CHANNEL = 'leads.update';

    public function handle($data)
    {
        $redis = Redis::connection();
        $redis->publish(self::CHANNEL, $data);
    }
}
