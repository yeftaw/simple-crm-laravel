<?php namespace YeftAw;


class JSHelper {

    public function __toString()
    {
        return json_encode(['token'=>csrf_token()]);
    }

}
