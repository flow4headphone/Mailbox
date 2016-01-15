<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body style="font-family: Open Sans;">
  
    <div class="container" style="margin-top: 10%;">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <center>
                    <p> Loading <%= session.getAttribute("email") %>@mymail.com </p>
                </center>
                <div class="progress">
                    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="min-width: 100%;"></div>
                </div>
                <center>
                    <p>Please wait!</p>
                </center>
            </div>
            <div class="col-md-3"></div>
        </div>
        

    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.progresstimer.js"></script>
    <script>
    var progress = $(".progress-bar").progressTimer({
        timeLimit: 2,
        onFinish: function () {
            window.location = "account.jsp";
        }
    });
    
    </script>
  </body>
</html>
