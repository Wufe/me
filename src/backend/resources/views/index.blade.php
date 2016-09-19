<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Me!</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="{{ asset('vendor/bootstrap/css/bootstrap.min.css') }}">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <script>
            if( !window.blade )
                window.blade = {};
            window.blade.data = {!! $data !!};
            window.blade.data.links =
                    @if (Route::has('login'))
                        [ [ "Login", "{{ url('/login') }}" ], [ "Register", "{{ url('/register') }}" ] ];
                    @else
                        [];
                    @endif
        </script>
    </head>
    <body>
        <div id="app"></div>
        <script type="text/javascript" src="{{ asset('javascript/main.bundle.js') }}"></script>
        <script type="text/javascript" src="{{ asset('javascript/vendor.bundle.js') }}"></script>
    </body>
</html>
