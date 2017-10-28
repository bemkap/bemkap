<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFixtureTable extends Migration
{
    public function up()
    {
        Schema::create('fixtures',function(Blueprint $table){
	    $table->increments('id');
	    $table->integer('team1_id');
	    $table->integer('score1');
	    $table->integer('team2_id');
	    $table->integer('score2');
	    $table->date('date');
	    $table->integer('day');
	    $table->integer('period');
	    $table->timestamps();
	});
    }
    public function down()
    {
	Schema::dropIfexists('fixtures');
    }
}
