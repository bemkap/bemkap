<?php

use Illuminate\Database\Seeder;

class FixtureTableSeeder extends Seeder
{
    public function run()
    {
        factory(App\Fixture::class)->create(['team1_id'=>4,'team2_id'=>5,'day'=>0,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>2,'team2_id'=>1,'day'=>0,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>3,'team2_id'=>2,'day'=>1,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>1,'team2_id'=>4,'day'=>1,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>1,'team2_id'=>5,'day'=>2,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>3,'team2_id'=>4,'day'=>2,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>4,'team2_id'=>2,'day'=>3,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>5,'team2_id'=>3,'day'=>3,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>3,'team2_id'=>1,'day'=>4,'period'=>2017]);
        factory(App\Fixture::class)->create(['team1_id'=>2,'team2_id'=>5,'day'=>4,'period'=>2017]);
    }
}
