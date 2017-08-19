<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTeamsTable extends Migration
{
    public function up()
    {
        Schema::create('teams',function(Blueprint $table){
	    $table->increments('id');
	    $table->string('name');
	    $table->timestamps();
	});
    }
    public function down()
    {
        Schema::dropIfexists('teams');
    }
}
