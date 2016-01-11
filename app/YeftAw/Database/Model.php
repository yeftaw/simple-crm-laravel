<?php namespace YeftAw\Database;

class Model extends \Eloquent
{
    public function updateRules()
    {
        $rules = static::$rules;
        foreach ($rules as $field => $rule) {
            // replace {ignore_id} with $model->id
            $rules[$field] = str_replace('{ignore_id}', $this->getKey(), $rule);
        }
        return $rules;
    }
}
