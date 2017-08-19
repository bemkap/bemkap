<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Teams extends Model
{
    protected $fillable=['name'];
    public function fixture(){
	return $this->hasMany(Fixture::class);
    }
}
