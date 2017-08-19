<?php

use Illuminate\Database\Seeder;

class NewsTableSeeder extends Seeder
{
    public function run()
    {
        factory(App\News::class)->times(50)->create();
    }
}
