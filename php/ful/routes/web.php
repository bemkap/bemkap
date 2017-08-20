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
    return view('welcome')->with('news',App\News::all());
});

Route::get('/news/{id}',function($id){
    $news=App\News::where('id',$id)->get()->first();
    return view('news_details')->with('news',$news);
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
            if(array_key_exists($e['original']['day'],$fixture)){
                array_push($fixture[$e['original']['day']],$e);
            }else{
                $fixture[$e['original']['day']]=array($e);
            }
        }
    }else{
	$fixture=[];
    }
    return view('fixture')->with('fixture',$fixture)
			  ->with('periods',$periods);
});

Route::get('/teams',function(){
    $teams=array();
    foreach(App\Fixture::all() as $match){
        $o=$match['original'];
        $teams[$o['team1_id']]['gmade']+=$o['score1'];
        $teams[$o['team2_id']]['gmade']+=$o['score2'];
        $teams[$o['team1_id']]['grecv']+=$o['score2'];
        $teams[$o['team2_id']]['grecv']+=$o['score1'];
        if($o['score1']>$o['score2']){
            $o['team1_id']['won']++;
            $o['team2_id']['lost']++;
        }else if($o['score1']<$o['score2']){
            $o['team1_id']['lost']++;
            $o['team2_id']['won']++;
        }else{
            $o['team1_id']['tie']++;
            $o['team2_id']['tie']++;
        }
        return view('teams')->with('fixture',App\Fixture::all())
                            ->with('teams',App\Teams::all());  
        return '';
    });
