<?php

use Illuminate\Support\Facades\DB;

/*
   |--------------------------------------------------------------------------
   | Web Routes
   |--------------------------------------------------------------------------
   |
   | Here is where you can register web routes for your application. These
   | routes are loaded by the RouteServiceProvider within a group which
   | contains the "web" middleware group. Now create something great!
   |
 */

Route::get('/',function (){
    $news=App\News::all();
    return view('welcome',compact('news'));
});

Route::get('/news/{id}',function($id){
    $news=App\News::where('id',$id)->get()->first();
    return view('news_details',compact('news'));
});

Route::get('/fixture',function(){
    $periods=App\Fixture::groupBy('period')
			->orderBy('period','desc')
			->get(['period']);
    if(request()->has('temp')){
	$old_arr=App\Fixture::where('period',request('temp'))
			    ->orderBy('day','desc')
			    ->get();
	$fixture=array();
	foreach($old_arr as $e){
	    array_push($fixture[$e['day']],$e);
	}
    }else{
	$fixture=[];
    }
    return view('fixture')->with('fixture',$fixture)
			  ->with('periods',$periods);
});
