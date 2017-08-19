@extends('layout')
@section('content')
  Temporada: 
  @foreach($periods as $period)
    <a href="?temp={{$period->period}}">{{$period->period}}</a> | 
  @endforeach
  <hr>
  <table class="table table-condensed table-striped" border="2">
    <tbody>
      <!-- @foreach($fixture as $match)
	   <tr>
	   <th class="th-s">{{$match->day}}</th>
	   <th class="th-l ac">{{$match->team1->name}}</th>
	   <th class="th-s ar">{{$match->score1}}</th>
	   <th class="th-s al">{{$match->score2}}</th>
	   <th class="th-l ac">{{$match->team2->name}}</th>
	   </tr>
	   @endforeach -->
    </tbody>
  </table>
@endsection
<style>
 .ar {
     text-align:right;
 }
 .ac {
     text-align:center;
 }
 .th-s {
     width:40px;
 }
 .th-l {
     width:120px;
 }
</style>
