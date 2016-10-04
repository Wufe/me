<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Me</title>
        
        <!-- Bootstrap -->
    	<link rel="stylesheet" href="vendor/bootstrap/bootstrap.min.css">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Raleway:100,600" rel="stylesheet" type="text/css">

        <script>
            if( !window.blade )
                window.blade = {};
            window.blade.data = {!! $data !!};
            window.blade.data.links = [];
        </script>
    </head>
    <body>
        <div id="app"></div>
    	<!-- Dependencies -->
    	<script src={{minjs('vendor/jquery/jquery.js')}}></script>
    	<script src={{minjs('vendor/bootstrap/bootstrap.js')}}></script>
        <script src={{minjs('vendor/react/react.js')}}></script>
        <script src={{minjs('vendor/react-dom/react-dom.js')}}></script>
        <!-- Main entrypoint -->
        <script src={{minjs('javascript/main.bundle.js')}}></script>
    </body>
</html>
