<?php

use Illuminate\Database\Seeder;

class FixtureTableSeeder extends Seeder
{
    public function run()
    {
        factory(App\Fixture::class)->times(30)->create();
    }
}
