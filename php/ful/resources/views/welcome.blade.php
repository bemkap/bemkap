@extends('layout')
@section('content')
  <div class="row">
    @for($i=0;$i<2;$i++)
      <div class="col-md-6">
	<h2>{{ $news[$i]->title }}</h2>
	<p class="input-sm">{{ $news[$i]->updated_at }}</p>
	<p class="panel-title">{{ $news[$i]->summary }}</p>
	<p><a class="btn btn-secondary" href="news/{{ $news[$i]->id }}" role="button">Detalles &raquo;</a></p>
      </div>
    @endfor
  </div>
  <div class="row">
    @for($i=2;$i<4;$i++)
      <div class="col-md-6">
	<h2>{{ $news[$i]->title }}</h2>
	<p class="input-sm">{{ $news[$i]->updated_at }}</p>
	<p>{{ $news[$i]->summary }}</p>
	<p><a class="btn btn-secondary" href="news/{{ $news[$i]->id }}" role="button">Detalles &raquo;</a></p>
      </div>
    @endfor
  </div>
  @for($i=4;$i<min(14,sizeof($news));$i++)
    <div class="row">
      <div class="col-md-0">
        <h2>{{ $news[$i]->title }}</h2>
	<p class="input-sm">{{ $news[$i]->updated_at }}</p>
        <p>{{ $news[$i]->summary }}</p>
        <p><a class="btn btn-secondary" href="news/{{ $news[$i]->id }}" role="button">Detalles &raquo;</a></p>
      </div>
    </div>
  @endfor
@endsection
