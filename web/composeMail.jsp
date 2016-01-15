
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("fname");
if (null == username) {
   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
   rd.forward(request, response);
}
if (null == request.getAttribute("senderNotFound")) {
   request.setAttribute("senderNotFound", "none");
    }
if (null == request.getAttribute("dbError")) {
   request.setAttribute("dbError", "none");
    }
if (null == request.getAttribute("sendSuccess")) {
   request.setAttribute("sendSuccess", "none");
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
    <link href="css/stylish.css" rel="stylesheet">
    <style>
        #sendError{
            display: <%= request.getAttribute("senderNotFound") %>;
        }
        #sendSuccess{
            display: <%= request.getAttribute("sendSuccess") %>;
        }
        #dbError {
            display: <%= request.getAttribute("dbError") %>;
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
                        <center>Something went seriously wrong!Please contact the developer.</center>
                    </div>
                    <div class="alert alert-danger" id="sendError" role="alert">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <center>Username not found. Please try again! If problem persists, contact the developer.</center>
                        
                    </div>
                    <div class="alert alert-success" id="sendSuccess" role="alert">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <center>Mail Sent successfully.</center>
                    </div>
                    <br>
                <div class="row">
                    <div class="col-md-2">
                        <ul id="myTab" class="nav nav-pills nav-tabs nav-stacked" style="border-radius: 0;">
                            <li role="presentation"  class="active"><a href="composeMail.jsp">Compose Mail</a></li>
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
                                        
                                        <center><h3>Compose Mail</h3></center>
                                        <hr>
                                        <form class="form-horizontal" id="composeForm" action="sendMail" method="POST" style="margin-left: 10px; margin-right:10px;">
                                            <div id="outer" class="form-group has-feedback">
                                                <label for="email_addr">To : </label>
                                                <div class="input-group has-feedback">
                                                    <input type="text" tabindex="1" id="recipient_addr" name="recipient_addr" class="form-control" placeholder="Enter Username">
                                                    <span class="input-group-btn has-feedback">
                                                        <button class="btn btn-default" type="button" disabled>@mymail.com</button>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="form-group has-feedback">
                                                <label for="subject">Subject : </label>
                                                <div class="input-group has-feedback">
                                                    <input type="text" size="60" tabindex="2" id="Subject" name="subject" style="border-radius: 3px;" class="form-control" placeholder="Subject">
                                                    <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group has-feedback">
                                                <label for="message">Message : </label>
                                                <div class="input-group has-feedback">
                                                    <textarea class="form-control" tabindex="3" name="message" id="Message" rows="10" cols="60" style="border-radius: 4px;" placeholder="Enter message here (Max : 1000 characters)."></textarea>
                                                    <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                                                </div>
                                            </div>
                                            <hr>
                                            <center>
                                                <div class="form-group">
                                              <div class="col-sm-12" style="margin-left: -15px;">
                                                  <input type="button" id="sendButton" value="Send Email" class="btn btn-success">
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
            
      </div>
                    
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                              <h4 class="modal-title" id="myModalLabel"><center>Confirmation</center></h4>
                            </div>
                            <div class="modal-body">
                                <center>Do you want to send message?</center>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Discard</button>
                              <button type="button" id="sendMessageButton" class="btn btn-primary">Send Mail</button>
                            </div>
                          </div>
                        </div>
                    </div>
                    
                    <hr>
                    <br><br>
    <!-- Script Section -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script>
        function validateField(key1)
        {
            var val = $("#"+key1).val();
            var max;
            if(key1==="subject")
                max = 50;
            if(key1==="message")
                max = 1000;
            if(val===null||val==="")
            {
                var div = $("#"+key1).closest("div");
                div.addClass("has-warning");
                div.removeClass("has-success");
                div.removeClass("has-error");
                $('#error'+key1).remove();
                
                div.append('<span id="error'+key1+'" style="color: red;font-size: 10px;display: none;">'+key1+' cannot be empty.</span>');
                $('#error'+key1).css({"display":"table"});
                $("#glyphcn"+key1).remove();
                div.append('<span id="glyphcn'+key1+'" class="glyphicon glyphicon-warning-sign form-control-feedback" aria-hidden="true"></span>');
                return false;
            }
            else if(val>=max)
            {
                var div = $("#"+key1).closest("div");
                div.removeClass("has-warning");
                div.removeClass("has-success");
                div.addClass("has-error");
                $('#error'+key1).remove();
                
                div.append('<span id="error'+key1+'" style="color: red;font-size: 10px;display: none;">Reached the max limit of '+max+' characters.</span>');
                $('#error'+key1).css({"display":"table"});
                $("#glyphcn"+key1).remove();
                div.append('<span id="glyphcn'+key1+'" class="glyphicon glyphicon-warning-sign form-control-feedback" aria-hidden="true"></span>');
                return false;
            }
            else
            {
                var div = $("#"+key1).closest("div");
                $('#error'+key1).css({"display":"none"});
                $("#error"+key1).remove();
                $('#glyphcn'+key1).remove();

                div.removeClass("has-warning");
                div.addClass("has-success");
                div.removeClass("has-error");

                div.append('<span id="glyphcn'+key1+'" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                return true;
            }
        }
        function validateAddress(key1)
        {
            var val = $("#"+key1).val();
            if(val===null||val==="")
            {
                var div = $("#"+key1).closest("div");
                div.addClass("has-warning");
                div.removeClass("has-success");
                div.removeClass("has-error");
                $('#error'+key1).remove();
                
                var div1 = $(div).parent();
                div1.append('<span id="error'+key1+'" style="color: red;font-size: 10px;display: none;">Please enter a username.</span>');
                $('#error'+key1).css({"display":"block"});
               
                div.append('<span id="glyphcn'+key1+'" style="right: 120px;" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                return false;
            }
            else
            {
                var div = $("#"+key1).closest("div");
                $('#error'+key1).css({"display":"none"});
                $("#error"+key1).remove();
                $('#glyphcn'+key1).remove();

                div.removeClass("has-warning");
                div.addClass("has-success");
                div.removeClass("has-error");

                div.append('<span id="glyphcn'+key1+'" style="right: 120px;" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                return true;
            }
        }
        $(document).ready(
            function()
            {
                $("#sendButton").click(function(){
                    validateAddress("recipient_addr");
                    validateField("Subject");
                    validateField("Message");
                    
                    if(validateAddress("recipient_addr")&&validateField("Subject")&&validateField("Message"))
                    {
                        $('#myModal').modal('show');
                    }
                    else
                        $('#myModal').modal('hide');
                    
                });
                $("#sendMessageButton").click(function(){
                    $("form#composeForm").submit();
                });
            }
        );
    </script>
  </body>
</html>
