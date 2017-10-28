<?php

/*
   |--------------------------------------------------------------------------
   | Model Factories
   |--------------------------------------------------------------------------
   |
   | Here you may define all of your model factories. Model factories give
   | you a convenient way to create models for testing and seeding your
   | database. Just tell the factory how a default model should look.
   |
 */

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(App\User::class, function (Faker\Generator $faker) {
    static $password;
    return [
        'name'=>$faker->name,
        'email'=>$faker->unique()->safeEmail,
        'password'=>$password?:$password=bcrypt('secret'),
        'remember_token'=>str_random(10),
    ];
});

$factory->define(App\News::class,function(Faker\Generator $faker){
    return [
        'title'=>$faker->sentence,
	'summary'=>$faker->paragraph,
        'content'=>$faker->text,
	'image'=>$faker->file('public/images/pastry','public/images',false),
    ];
});

$factory->define(App\Teams::class,function(Faker\Generator $faker){
    return [
	'name'=>$faker->lastName,
    ];
});

$factory->define(App\Fixture::class,function(Faker\Generator $faker){
    return [
	'team1_id'=>App\Teams::all()->random()->id,
	'score1'=>$faker->randomDigitNotNull,
	'team2_id'=>App\Teams::all()->random()->id,
	'score2'=>$faker->randomDigitNotNull,
	'date'=>$faker->date,
	'day'=>$faker->numberBetween(1,20),
	'period'=>$faker->numberBetween(2000,2020),
    ];
});

$factory->define(App\Goal::class,function(Faker\Generator $faker){
    return [
	'day'=>App\Fixture::all()->random()->day,
	'period'=>App\Fixture::all()->random()->period,
	'player'=>$faker->firstName,
    ];
});
