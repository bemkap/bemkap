@extends('layout')
@section('content')
    Temporada: 
    @foreach($periods as $period)
        <a href="?temp={{$period->period}}">{{$period->period}}</a> | 
    @endforeach
    <hr>
    @foreach($fixture as $d)
        <h4 style="text-align:center">Fecha {{$d[0]->day}}</h4>
        <table class="table table-condensed table-striped" border="2">
            <tbody>
                @foreach($d as $e)
                    <tr>
                        <th class="th-l ar">{{$e->team1->name}}</th>
                        <!-- <th class="th-s ac">{{$e->score1}}</th>
                             <th class="th-s ac">{{$e->score2}}</th> -->
                        <th class="th-l al">{{$e->team2->name}}</th>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @endforeach
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
