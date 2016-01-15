
import java.sql.Statement;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class auth extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        RequestDispatcher success = request.getRequestDispatcher("/loading.jsp");
        RequestDispatcher failure = request.getRequestDispatcher("/login.jsp");
        
        String url = "jdbc:derby://localhost:1527/mailbox";
        String user_name = "root";
        String pass_word = "rootuser";
        String email_addr = request.getParameter("email_addr");
        String pass_key = request.getParameter("pass");
        
        String query = "SELECT * FROM ROOT.\"users\" WHERE EMAIL_ADD='"+email_addr+"' AND PASS_KEY='"+pass_key+"'";
       
        try(Connection con = DriverManager.getConnection(url, user_name, pass_word))
        {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            
            
            
            
            /* For creating sessions*/
                HttpSession session = request.getSession(true);
            /*  ****************    */ 
            
            if(rs.next())
            {
                if(rs.getString("EMAIL_ADD").equalsIgnoreCase(email_addr)&&rs.getString("PASS_KEY").equals(pass_key))
                {
                    
                    session.setAttribute("sr", rs.getInt("sr"));
                    session.setAttribute("fname", rs.getString("FNAME"));
                    session.setAttribute("lname", rs.getString("LNAME"));
                    session.setAttribute("email", rs.getString("EMAIL_ADD"));
                    session.setAttribute("pass", rs.getString("PASS_KEY"));
                    session.setAttribute("gender", rs.getString("GENDER"));
                    session.setAttribute("contact", rs.getString("CONTACT"));
                    session.setAttribute("birth", rs.getString("BIRTH"));
                    
                    success.forward(request, response);
                }
                else
                {
                    request.setAttribute("loginError", "block");
                    failure.forward(request, response);
                }
            }
            else
            {
                request.setAttribute("loginError", "block");
                failure.forward(request, response);
            }
        }
        catch(Exception e)
        {
            request.setAttribute("dbError", "block");
            failure.forward(request, response);
        }
                  
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
