<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Klasifikasi;

class KlasifikasiSeeder extends Seeder
{
    public function run(): void
    {
        $data = [
            ['kode_klasifikasi' => 'A1234', 'nama' => 'Surat ABCD'],
            ['kode_klasifikasi' => 'B5678', 'nama' => 'Surat EFGH'],
            ['kode_klasifikasi' => 'C9101', 'nama' => 'Surat IJKL'],
        ];

        foreach ($data as $item) {
            Klasifikasi::updateOrCreate(
                ['kode_klasifikasi' => $item['kode_klasifikasi']],
                ['nama' => $item['nama']]
            );
        }
    }
}