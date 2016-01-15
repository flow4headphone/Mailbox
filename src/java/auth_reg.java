import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class auth_reg extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException
    {
        String temp1 = request.getParameter("fname");
        String firstName = temp1.substring(0, 1).toUpperCase() + temp1.substring(1);
        
        String temp2 = request.getParameter("lname");
        String lastName = temp2.substring(0, 1).toUpperCase() + temp2.substring(1);
        
        String emailAddress = request.getParameter("email_addr");
        String password = request.getParameter("pass");
        String gender = request.getParameter("Gender");
        String contact = request.getParameter("contact");
        String birthDay = request.getParameter("Day");
        String birthMonth = request.getParameter("Month");
        String birthYear = request.getParameter("year");
        String birth = birthDay + "/" + birthMonth + "/" + birthYear;
        String contactNumber = request.getParameter("contact");
        
        String url = "jdbc:derby://localhost:1527/mailbox";
        String user_name = "root";
        String pass_word = "rootuser";
        try(Connection con = DriverManager.getConnection(url, user_name, pass_word))
        {
            Statement st1 = con.createStatement();
            int rs = st1.executeUpdate("insert into ROOT.\"users\"(FNAME,LNAME,EMAIL_ADD,PASS_KEY,GENDER,CONTACT,BIRTH) values"
                    + "('"+firstName+"','"+lastName+"','"+emailAddress+"','"+password+"','"+gender+"','"+contactNumber+"','"+birth+"')");
            
            if(rs==1)
            {
                Statement st2 = con.createStatement();
                int rs2 = st2.executeUpdate("CREATE TABLE \""+emailAddress+"\"(\"sr\" INT not null primary key GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),"
                + "\"STATUS\" VARCHAR(20) not null,"
                + "\"EMAIL_ADD\" VARCHAR(30) not null,"
                + "\"SUBJECT\" VARCHAR(60) not null,"
                + "\"MESSAGE\" VARCHAR(1000) not null,"
                + "\"VIEWED\" VARCHAR(5) not null,"
                + "\"TIMEDAY\" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
                
                if(rs2==0)
                {
                    request.setAttribute("success_reg", "block");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
                else
                {
                    request.setAttribute("success_reg", "block");
                    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                    rd.forward(request, response);
                }
            }
            else
            {
                request.setAttribute("success_reg", "block");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);
            }
            
        }
        catch(Exception e)
        {
            request.setAttribute("success_reg", "block");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(auth_reg.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(auth_reg.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
