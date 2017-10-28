<?php

use Illuminate\Database\Seeder;

class GoalTableSeeder extends Seeder
{
    public function run()
    {
        factory(App\Goal::class)->times(100)->create();
    }
}
