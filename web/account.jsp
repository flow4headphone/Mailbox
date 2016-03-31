<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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

<%!

// the "url" to our DB, the last part is the name of the DB
String url = "jdbc:derby://localhost:1527/mailbox";
// the default DB username and password
String name = "root";
String pass = "rootuser";
%>

<%
    Connection con = null;
    String queryCount = "SELECT COUNT(*) AS NEWMAIL FROM ROOT.\""+session.getAttribute("email")+"\" WHERE STATUS='RECEIVED' AND VIEWED='NO'";
    try
    {
        con = DriverManager.getConnection(url, name, pass);
        Statement stCount = con.createStatement();
        int count = 0;
        ResultSet rsCount = stCount.executeQuery(queryCount);
        if(rsCount.next())
        {
            count = rsCount.getInt(1);
        }
        else
        {
            count = 0;
        }
        session.setAttribute("newmailcount", count);
    }
    catch(Exception e)
    {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
    finally
    {
        con.close();
    }
%>



<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MailBox - <%= session.getAttribute("newmailcount")%> New Mails</title>
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
                            <li role="presentation"><a href="composeMail.jsp">Compose Mail</a></li>
                            <li role="presentation"  class="active">
                                <a href="#inboxTab" data-toggle="tab">
                                    Inbox
                                    <span class="badge" style="float: right;">
                                        <%= session.getAttribute("newmailcount") %>&nbsp;
                                        <span class="glyphicon glyphicon glyphicon-star-empty" aria-hidden="true">
                                        </span>
                                    </span>
                                </a>
                            </li>
                            <li role="presentation"><a href="#sentTab" data-toggle="tab">Sent Mail</a></li>
                      </ul>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane active" id="inboxTab">
                                <div class="container" style="width: 111%;">
                                    <div class="row">
                                        <div class="col-md-1 col-md-offset-0">
                                            <a onclick="window.location.href=this" class="btn btn-remove btn-sm">
                                                <span class="glyphicon glyphicon glyphicon glyphicon-refresh" aria-hidden="true"></span> : Click here to Refresh
                                            </a>
                                        </div>
                                        <div class="col-md-2 col-md-offset-9">
                                            <a class="btn btn-remove btn-sm">
                                                <span class="glyphicon glyphicon glyphicon-eye-open" aria-hidden="true"></span> : View
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="bootstrap-demo" style="width: 111%;">
                                            <table class="table" style="font-size: 12px;">
                                                    <thead>
                                                        <tr>
                                                            <th class="col-md-6">Mail Message</th>
                                                            <th class="col-md-3">Time</th>
                                                            <th class="col-xs-1">Action</th>
                                                        </tr>
                                                    </thead>

                                                    <tbody>
                                                        <%
                                                            String queryInbox = "SELECT * FROM ROOT.\""+session.getAttribute("email")+"\" WHERE STATUS='RECEIVED' ORDER BY VIEWED";
                                                            try
                                                            {
                                                                con = DriverManager.getConnection(url, name, pass);
                                                                Statement stInbox = con.createStatement();
                                                                ResultSet rsInbox = stInbox.executeQuery(queryInbox);
                                                                
                                                                while(rsInbox.next())
                                                                {
                                                                    String viewStatus = rsInbox.getString("VIEWED");
                                                                    String viewIcon = null;
                                                                    if(viewStatus.equalsIgnoreCase("NO"))
                                                                    {
                                                                        viewStatus = "success";
                                                                        viewIcon = "inline";
                                                                    }
                                                                    else
                                                                    {
                                                                        viewStatus = "";
                                                                        viewIcon = "none";
                                                                    }
                                                        %>
                                                                    <tr class= <%= viewStatus %> >
                                                                        <td>New Message from <strong><%= rsInbox.getString("EMAIL_ADD") %>@mymail.com</strong> <span class="glyphicon glyphicon glyphicon-star-empty" style="display: <%= viewIcon %>" aria-hidden="true"></span></td>
                                                                        <td><%= rsInbox.getString("TIMEDAY") %></td>
                                                                        <td>
                                                                            <form action="viewAuth" method="POST">
                                                                                <button type="submit" href="" class="btn btn-default btn-sm" value="<%= rsInbox.getInt("sr") %>" name="viewToggle">
                                                                                    <span class="glyphicon glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                                                                                </button>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                        <%
                                                                }
                                                            }
                                                            catch(Exception e)
                                                            {
                                                                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                                                rd.forward(request, response);
                                                            }
                                                            finally
                                                            {
                                                                con.close();
                                                            }
                                                        %>
                                                        
                                                    </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                                        
                            <div class="tab-pane" id="sentTab">
                                <div class="container" style="width: 111%;">
                                    <div class="row">
                                        <div class="col-md-1 col-md-offset-0">
                                            <a onclick="window.location.href=this" class="btn btn-remove btn-sm">
                                                <span class="glyphicon glyphicon glyphicon glyphicon-refresh" aria-hidden="true"></span> : Click here to Refresh
                                            </a>
                                        </div>
                                        <div class="col-md-2 col-md-offset-9">
                                            <a class="btn btn-remove btn-sm">
                                                <span class="glyphicon glyphicon glyphicon-eye-open" aria-hidden="true"></span> : View
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="bootstrap-demo" style="width: 111%;">
                                            <table class="table"  style="font-size: 12px;">
                                                    <thead>
                                                        <tr>
                                                            <th class="col-md-6">Mail Message</th>
                                                            <th class="col-md-3">Time</th>
                                                            <th class="col-xs-1">Action</th>
                                                        </tr>
                                                    </thead>

                                                    <tbody>
                                                        <%
                                                            String querySent = "SELECT * FROM ROOT.\""+session.getAttribute("email")+"\" WHERE STATUS='SEND'";
                                                            try
                                                            {
                                                                con = DriverManager.getConnection(url, name, pass);
                                                                Statement stInbox = con.createStatement();
                                                                ResultSet rsInbox = stInbox.executeQuery(querySent);
                                                                
                                                                while(rsInbox.next())
                                                                {
                                                        %>
                                                                    <tr>
                                                                        <td>Sent mail to <strong><%= rsInbox.getString("EMAIL_ADD") %>@mymail.com</strong></td>
                                                                        <td><%= rsInbox.getString("TIMEDAY") %></td>
                                                                        <td>
                                                                            <form action="viewAuth" method="POST">
                                                                                <button type="submit" href="" class="btn btn-default btn-sm" value="<%= rsInbox.getInt("sr") %>" name="viewToggle">
                                                                                    <span class="glyphicon glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                                                                                </button>
                                                                            </form>
                                                                        </td>
                                                                    </tr>
                                                        <%
                                                                }
                                                            }
                                                            catch(Exception e)
                                                            {
                                                                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                                                rd.forward(request, response);
                                                            }
                                                            finally
                                                            {
                                                                con.close();
                                                            }
                                                        %>
                                                        
                                                    </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
      </div>
    <div class="container">
        <hr>
        <center><p style="color: #0f0f0f; font-size: 12px;">Developed By <em><strong>Rushabh Wadkar</strong></em>. All rights reserved &reg; </p></center>
        <hr>
    </div>
    <br><br>
    <!-- Script Section -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
