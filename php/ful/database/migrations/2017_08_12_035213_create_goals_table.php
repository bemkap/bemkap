<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateGoalsTable extends Migration
{
    public function up()
    {
	Schema::create('goals',function(Blueprint $table){
	    $table->integer('day');
	    $table->integer('period');
	    $table->string('player');
	    $table->timestamps();
	});
    }
    public function down()
    {
        Schema::dropifexists('goals');
    }
}
