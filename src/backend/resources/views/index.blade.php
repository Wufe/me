<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Me!</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <script src="vendor/jquery/jquery.slim.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

        <script>
            if( !window.blade )
                window.blade = {};
            window.blade.data = {!! $data !!};
            window.blade.data.links = [];
        </script>
    </head>
    <body>
        <div id="app"></div>
        <script type="text/javascript" src="javascript/main.bundle.js"></script>
        <script type="text/javascript" src="javascript/vendor.bundle.js"></script>
    </body>
</html>
