<?php

namespace App\Providers;

use Carbon\Carbon;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Set default timezone ke Indonesia
        date_default_timezone_set('Asia/Jakarta');

        // Optional: paksa Carbon pakai locale Indonesia
        Carbon::setLocale('id');
    }
}