
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (null == request.getAttribute("success_reg")) {
   request.setAttribute("success_reg", "none");
    }
    if (null == request.getAttribute("loginError")) {
   request.setAttribute("loginError", "none");
    }
    if (null == request.getAttribute("dbError")) {
   request.setAttribute("dbError", "none");
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
    <style>
        #wrong_reg{
            display: <%= request.getAttribute("success_reg") %>;
        }
        #wrong_login{
            display: <%= request.getAttribute("loginError") %>;
        }
        #wrong_db{
            display: <%= request.getAttribute("dbError") %>;
        }
    </style>
  </head>
  <body style="
        background-repeat: no-repeat;
        background-attachment: fixed;
        font-family: Open Sans;
  ">
      <br>
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
                <a class="navbar-brand" href="index.html">My MailBox</a>
              </div>

              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                  <li><a href="index.html">Go to HomePage</a></li>
                  <li><a href="register.jsp">Register</a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                       <li><a href="terms.html">Terms And Conditions</a></li>
                      <li><a href="aboutme.html">About Developer</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
            
      </div>
     </nav>
      
      <div class="alert alert-success" id="wrong_reg" role="alert">
          <center>Congrats, Successfully registered! Please login below to Get Started.</center>
      </div>
      <div class="alert alert-danger" id="wrong_login" role="alert">
          <center>This Username not found in Database! Please register and try again!</center>
      </div>
      <div class="alert alert-danger" id="wrong_db" role="alert">
          <center>Something went seriously wrong! Please contact the administrator.</center>
      </div>
      <br>
      <div class="container">
              <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-5">
                    <div class="jumbotron" style="background-color: white;border-style: solid; border-width: 0px; border-color: black; box-shadow: 10px 10px 35px #D3D4D5;">
                        <div class="jumbotron" style="padding: 5px !important; background-color: #00EFFF;">
                            <span><center>MAILBOX LOGIN</center></span>
                        </div>
                        <form class="form-horizontal" action="auth" method="POST" style="margin-left: 10px; margin-right:10px;">
                            <div class="form-group">
                                <label for="email_addr">Enter Username : </label>
                                <div class="input-group">
                                    <input type="text" tabindex="1" id="emai_addr" name="email_addr" required class="form-control" placeholder="example">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" disabled>@mymail.com</button>
                                    </span>
                                </div>
                            </div>
                            
                            <div class="form-group has-feedback">
                                <label for="pass">Enter Password : </label>
                                <input type="password" tabindex="2" id="pass" name="pass" class="form-control" required placeholder="Password">
                                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                            </div>

                            <div class="form-group" style="margin-bottom: -20px;">
                              <div class="col-sm-offset-5 col-sm-12">
                                  <input type="submit" value="Login" class="btn btn-success">
                              </div>
                            </div>
                          </form>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
          </div>
      </div>
      <hr>
      
    <!-- Script Section -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
