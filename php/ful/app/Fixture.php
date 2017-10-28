<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Fixture extends Model
{
    protected $fillable=['team1_id','score1','team2_id','score2'];
    public function team1(){
	return $this->belongsTo(Teams::class);
    }
    public function team2(){
	return $this->belongsTo(Teams::class);
    }
}
