import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class viewAuth extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        RequestDispatcher success = request.getRequestDispatcher("viewMail.jsp");
        RequestDispatcher failure = request.getRequestDispatcher("account.jsp");
        HttpSession session = request.getSession(true);
        
        int serialID = Integer.parseInt(request.getParameter("viewToggle"));
        String url = "jdbc:derby://localhost:1527/mailbox";
        String user_name = "root";
        String pass_word = "rootuser";
        String queryView = "SELECT * FROM ROOT.\""+ session.getAttribute("email") +"\" where \"sr\" = " + serialID + "";
        
        try(Connection con = DriverManager.getConnection(url, user_name, pass_word))
        {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(queryView);
            
            if(rs.next())
            {
                String viewMark = "UPDATE ROOT.\"" + session.getAttribute("email") +"\" SET VIEWED='YES' WHERE \"sr\"="+serialID+"";
                Statement stMark = con.createStatement();
                boolean rsMark = stMark.execute(viewMark);
            
                request.setAttribute("viewsr",rs.getInt("sr"));
                request.setAttribute("viewSR", rs.getString("STATUS"));
                request.setAttribute("viewemail", rs.getString("EMAIL_ADD"));
                request.setAttribute("viewsubject", rs.getString("SUBJECT"));
                request.setAttribute("viewmessage", rs.getString("MESSAGE"));
                request.setAttribute("viewstatus", rs.getString("VIEWED"));
                request.setAttribute("viewday", rs.getString("TIMEDAY"));
                success.forward(request, response);
            }
            else
            {
                failure.forward(request, response);
            }
        }
        catch(Exception e)
        {
            PrintWriter pw = response.getWriter();
            pw.println(e);
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
