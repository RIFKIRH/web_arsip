@php
    use Carbon\Carbon;
@endphp
@extends('layouts.main')

@section('content')
        <div class="card">
        <div class="card-body">
            <div class="mt-3 mb-2">
                @if (session('success'))
                    <div class="alert alert-success">
                        {{ session('success') }}
                    </div>
                @endif
                <a href="{{ route('arsip.create') }}" class="btn btn-primary" style="width: max-content">
                    <i class="bi bi-plus"></i> Arsip Dokmen
                </a>
            </div>
            <!-- Table with hoverable rows -->
            <table class="table table-hover table-stripped" id="dataTable">
                <thead class="table-primary">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">File</th>
                        <th scope="col">Jumlah</th>
                        <th scope="col">Tingkat Perkembangan</th>
                        <th scope="col">Keterangan Nomor Box</th>
                        <th scope="col">Kurun Waktu</th>
                        <th scope="col">Aksi</th>
                    </tr>
                </thead>
            </table>
            <!-- End Table with hoverable rows -->
        </div>
    </div>
@endsection
@push('scripts')
    <script>
        $(document).ready(function() {
            const table = $("#dataTable").DataTable({
                processing: true,
                serverSide: true,
                ajax: {
                    url: "{{ route('arsip.data') }}",
                },
                columns: [
                    {
                        data: 'DT_RowIndex',
                        name: 'DT_RowIndex',
                        orderable: false,
                        searchable: false
                    },
                    {
                        data: 'url_file',
                        name: 'url_file',
                        orderable: false,
                    },
                    {
                        data: 'jumlah',
                        name: 'jumlah',
                        orderable: false,
                    },
                    {
                        data: 'tingkat_perkembangan',
                        name: 'tingkat_perkembangan',
                        orderable: false,
                    },
                    {
                        data: 'keterangan_nomor_box',
                        name: 'keterangan_nomor_box',
                        orderable: false,
                    },
                    {
                        data: 'kurun_waktu',
                        name: 'kurun_waktu',
                        orderable: false,
                        searchable: false
                    },
                    {
                        data: 'action',
                        name: 'action',
                        orderable: false,
                        searchable: false
                    },
                ],
            })
        })
    </script>
    <script>
        $(document).on("submit", ".formDelete", function(e) {
            e.preventDefault();
            Swal.fire({
                title: 'Apakah Anda yakin?',
                text: "Arsip ini akan dihapus secara permanen!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Ya, hapus!',
                cancelButtonText: 'Batal'
            }).then((result) => {
                if (result.isConfirmed) {
                    e.currentTarget.submit()
                }
            });
        })
    </script>
@endpush
