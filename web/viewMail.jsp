
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String toFrom = null;
String srno = (String)request.getAttribute("viewstatus");
if (null == srno) {
    srno = "block";
}
else
{
    srno = "none";
    toFrom = (String) request.getAttribute("viewSR");
    if(toFrom.equalsIgnoreCase("SEND"))
        toFrom = "To : ";
    else
        toFrom = "From : ";
}

   request.setAttribute("disp", srno);
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
    <link href="css/stylish.css" rel="stylesheet">
    <style>
        #dbError{
            display: <%= request.getAttribute("disp") %>;
        }
    </style>
  </head>
  <body style="
        font-family: Open Sans;
        background-color: white;">
      
      <div class="container">
        <nav class="navbar navbar-default" style="background-color: white; border: none;">
          
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
                  <li><a href="#">Settings</a></li>
                  <li><a href="logout.jsp">Logout</a></li>
                  
                </ul>
              </div>
            </div>
        
            </nav> 
      
      
                <div class="my-container">
                    <h2>'Welcome, <%= session.getAttribute("fname") %>&nbsp;<%= session.getAttribute("lname") %>'</h2>
                    <h6> It's great to have you here, back again! Check your mails.</h6>
                    <br>
                </div>
                    <div class="alert alert-danger" id="dbError" role="alert">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <center>Something went wrong! PLease go back.</center>
                    </div>
                    <br>
                <div class="row">
                    <div class="col-md-2">
                        <ul id="myTab" class="nav nav-pills nav-tabs nav-stacked" style="border-radius: 0;">
                            <li role="presentation"><a href="composeMail.jsp">Compose Mail</a></li>
                            <li role="presentation"><a href="account.jsp">Inbox<span class="badge" style="float: right;"><%= session.getAttribute("newmailcount") %>&nbsp;<span class="glyphicon glyphicon glyphicon-star-empty" aria-hidden="true"></span></span></a></li>
                            <li role="presentation"><a href="account.jsp">Sent Mail</a></li>
                      </ul>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane active" id="composeTab">
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-6" style="border: 1px solid white; padding: 50px; box-shadow: 7px 7px 30px #737373;">
                                        
                                        <center><h3>View Message</h3></center>
                                        <hr>
                                        <form class="form-horizontal" id="composeForm" action="account.jsp" action="POST" style="margin-left: 10px; margin-right:10px;">
                                            <div class="form-group has-feedback">
                                                <p><label for="to"><%= toFrom %>&nbsp;</label><%= request.getAttribute("viewemail") %>@mymail.com</p>
                                            </div>

                                            <div class="form-group has-feedback">
                                                <p><label for="subject">Time : &nbsp;</label><%= request.getAttribute("viewday") %></p>
                                            </div>
                                            
                                            <div class="form-group has-feedback">
                                                <p><label for="subject">Subject : &nbsp;</label><%= request.getAttribute("viewsubject") %></p>
                                            </div>
                                            
                                            <div class="form-group has-feedback">
                                                <p><label for="message">Message : &nbsp;</label><%= request.getAttribute("viewmessage") %></p>
                                            </div>
                                            <hr>
                                            <center>
                                                <div class="form-group">
                                                    <div class="col-sm-12" style="margin-left: -15px; margin-bottom: -30px;">
                                                        <input type="submit" id="sendButton" value="Back to Inbox" class="btn btn-success">
                                                    </div>
                                                </div>
                                            </center>
                                          </form>
                                    </div>
                                    <div class="col-md-3"></div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                <hr>
                <br>
    <!-- Script Section -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
  </body>
</html>
