<?php namespace YevtAw\Leads;

use Redis;
use Response;

class LeadstatusUpdatedEventHandler {

    CONST EVENT = 'leadstatuses.update';
    CONST CHANNEL = 'leadstatuses.update';

    public function handle($data)
    {
        $redis = Redis::connection();
        $redis->publish(self::CHANNEL, $data);
    }
}
