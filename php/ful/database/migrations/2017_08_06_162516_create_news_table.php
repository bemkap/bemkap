<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateNewsTable extends Migration
{
    public function up()
    {
        Schema::create('news',function(Blueprint $table){
            $table->increments('id');
            $table->mediumText('title');
	    $table->mediumText('summary');
            $table->longText('content');
	    $table->text('image');
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('news');
    }
}
