import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class sendMail extends HttpServlet
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException
    {
        String url = "jdbc:derby://localhost:1527/mailbox";
        String user_name = "root";
        String pass_word = "rootuser";
        
        String address = request.getParameter("recipient_addr").toLowerCase();
        String subject = request.getParameter("subject");
        String messageBody = request.getParameter("message");
        
        HttpSession session = request.getSession(true);
        String myAddress = (String) session.getAttribute("email");
        
        String queryIdentify = "SELECT * FROM ROOT.\"users\" WHERE EMAIL_ADD='"+address+"'";
        
        String querySender = "insert into ROOT.\""+myAddress+"\"(STATUS,EMAIL_ADD,SUBJECT,MESSAGE,VIEWED) " +
                "values('SEND', '"+address+"','"+subject+"' ,'"+messageBody+"' , 'YES')";
        String queryReceiver = "insert into ROOT.\""+address+"\"(STATUS,EMAIL_ADD,SUBJECT,MESSAGE,VIEWED) " +
                "values('RECEIVED', '"+myAddress+"','"+subject+"', '"+messageBody+"' , 'NO')";
        
        try(Connection con = DriverManager.getConnection(url, user_name, pass_word))
        {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(queryIdentify);
            
            if(rs.next())
            {
                Statement stSend = con.createStatement();
                int rsSend = stSend.executeUpdate(querySender);
                Statement stReceive = con.createStatement();
                int rsReceive = stReceive.executeUpdate(queryReceiver);

                if(rsSend==1)
                {
                    request.setAttribute("sendSuccess", "block");
                    RequestDispatcher rd = request.getRequestDispatcher("composeMail.jsp");
                    rd.forward(request, response);
                }
                else
                {
                    request.setAttribute("senderNotFound", "block");
                    RequestDispatcher rd = request.getRequestDispatcher("composeMail.jsp");
                    rd.forward(request, response);
                }
            }
            else
            {
                request.setAttribute("senderNotFound", "block");
                RequestDispatcher rd = request.getRequestDispatcher("composeMail.jsp");
                rd.forward(request, response);
            }
            
        }
        catch(Exception e)
        {
            request.setAttribute("dbError", "block");
            RequestDispatcher rd = request.getRequestDispatcher("composeMail.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(sendMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(sendMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
