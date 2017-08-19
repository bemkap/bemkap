@extends('layout')
@section('content')
  <div class="col-md-0">
    <h2>{{ $news->title }}</h2>
    <p class="input-sm">{{ $news->updated_at }}</p>
    <p class="input-lg panel-title">{{ $news->summary }}</p>
    <br/>
    <img style="float:right" src="../images/{{ $news->image }}" height="320" width="320">
    <p class="panel-title">{{ $news->content }}</p>
    <p style="clear:right"><a class="btn btn-secondary" href="/" role="button">&raquo; Volver</a></p>
  </div>
@endsection
