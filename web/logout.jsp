
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("fname");
if (null == username) {
   request.setAttribute("Error", "Session has ended.  Please login.");
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}
else
{
    session.invalidate();
}
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MailBox</title>
    <link rel="icon" type="image/png" href="img/mail.png" />
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body style="
        background-repeat: no-repeat;
        background-attachment: fixed;
        font-family: Open Sans;
  ">
      
    <nav class="navbar navbar-default" style="border: none; background-color: white; border-radius: 0;">
        <div class="container">
          
            <div class="container-fluid">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                  
                <img alt="Brand" src="img/mail.png" height="30" width="30" style="margin-top: 10px;">
                <a class="navbar-brand" href="#">My MailBox</a>
              </div>

              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="register.jsp">Registration</a></li>
                  <li><a href="login.jsp">Login</a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                      <li><a href="#">Terms And Conditions</a></li>
                      <li><a href="#">About Developer</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
            
      </div>
     </nav>
      
      
      <br><br>
      <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <center>
                          <p>Logging out! Please wait.</p>
                          <div class="progress">
                              <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="min-width: 100%;"></div>
                          </div>
                          <br>
                          <img src="img/logout.png" style="margin-left: 10px;"/>
                          <br>
                          <p style="font-size: 2.5em;">Thanks for Stopping by!</p>
                          <br>
                          <p>We hope to see you soon!</p>
                    </center>
                </div>
                <div class="col-md-4"></div>
            </div>
      </div>

    <!-- Script Section --> 
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.progresstimer.js"></script>
    <script>
    var progress = $(".progress-bar").progressTimer({
        timeLimit: 1.5,
        onFinish: function () {
            window.location = "login.jsp";
        }
    });
    
    </script>
   
  </body>
</html>