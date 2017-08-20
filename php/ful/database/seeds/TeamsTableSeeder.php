<?php

use Illuminate\Database\Seeder;

class TeamsTableSeeder extends Seeder
{
    public function run()
    {
	factory(App\Teams::class)->create(['name'=>'america']);
        factory(App\Teams::class)->create(['name'=>'europa']);
        factory(App\Teams::class)->create(['name'=>'africa']);
        factory(App\Teams::class)->create(['name'=>'asia']);
        factory(App\Teams::class)->create(['name'=>'oceania']);
    }
}
