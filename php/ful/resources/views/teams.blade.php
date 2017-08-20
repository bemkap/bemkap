@extends('layout')
@section('content')
    <table>
        <tbody>
            @foreach($teams as $team)
                <tr><th>{{$team->name}}</th></tr>
            @endforeach
        </tbody>
    </table>
@endsection
