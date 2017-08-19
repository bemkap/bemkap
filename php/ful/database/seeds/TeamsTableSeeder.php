<?php

use Illuminate\Database\Seeder;

class TeamsTableSeeder extends Seeder
{
    public function run()
    {
	factory(App\Teams::class)->times(10)->create();
    }
}
