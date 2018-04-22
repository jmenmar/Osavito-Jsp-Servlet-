/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JAVIER
 */
public class pedirCita extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private Connection con;
    private Statement set;
    private ResultSet rs;
    private int numCodigo;
    private int contador,contadorPac;
    
    @Override
    public void init(ServletConfig cfg) throws ServletException {
        String sURL = "jdbc:mysql://localhost/bdosavito03b";
        super.init(cfg);
        String userName = "root";
        String password = "root";
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection(sURL, userName, password);
            System.out.println("Se ha conectado.");
        } catch (ClassNotFoundException ex1) {
            System.out.println("No se ha conectado: " + ex1);
        } catch (IllegalAccessException ex2) {
            System.out.println("No se ha conectado: " + ex2);
        } catch (InstantiationException ex3) {
            System.out.println("No se ha conectado: " + ex3);
        } catch (SQLException ex4) {
            System.out.println("No se ha conectado:" + ex4);
        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet pedirCita</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet pedirCita at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        HttpSession s = req.getSession(true);
        
        String numColegiado = (String) req.getParameter("sanitario");
        s.setAttribute("san", numColegiado);
        
        String sesionTIS = (String) s.getAttribute("tis");
        
        String fecha = (String) req.getParameter("fecha");
        s.setAttribute("fec", fecha);
        
        String hora = (String) req.getParameter("hora");
        s.setAttribute("hor", hora);
        
        String min = (String) req.getParameter("min");
        s.setAttribute("min", min);
        
        // COMPROBAR SI PACIENTE TIENE CITA A LA HORA SOLICITADA CON OTRO SANITARIO
        try {
            contadorPac=0;
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM citas WHERE TIS="+sesionTIS+" AND Fecha='"+fecha+"' AND Hora='"+hora+":"+min+":00';");
            while(rs.next()){
                contadorPac++;
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
                System.out.println("No se ha podido contar el número de citas." + ex1);
        }
        // COMPROBAR SI SANITARIO TIENE CITAS A LA HORA SOLICITADA
        try {
            contador=0;
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM citas WHERE NumColegiado="+numColegiado+" AND Fecha='"+fecha+"' AND Hora='"+hora+":"+min+":00';");
            while(rs.next()){
                contador++;
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
                System.out.println("No se ha podido contar el número de citas." + ex1);
        }
        
        if(hora.equals("10") && !min.equals("00")){
            //Horario > 10:00 no disponible
            PrintWriter out = res.getWriter();  
            res.setContentType("text/html");  
            out.println("<script type=\"text/javascript\">");  
            out.println("alert('Horario no disponible. El último turno es a las 10:00.');");  
            out.println("window.location = \"pedirCita.jsp\";"); 
            out.println("</script>");
        }else if(contador>0){
            //Sanitario ya tiene cita a esa hora con un paciente
            PrintWriter out = res.getWriter();  
            res.setContentType("text/html");  
            out.println("<script type=\"text/javascript\">");  
            out.println("alert('El sanitario ya tiene una cita a esa hora con un paciente');");  
            out.println("window.location = \"pedirCita.jsp\";"); 
            out.println("</script>");
        }else if(contadorPac>0){
            //Sanitario ya tiene cita a esa hora con un paciente
            PrintWriter out = res.getWriter();  
            res.setContentType("text/html");  
            out.println("<script type=\"text/javascript\">");  
            out.println("alert('Ya tienes una cita a esa misma hora');");  
            out.println("window.location = \"pedirCita.jsp\";"); 
            out.println("</script>");
        }else{
            try {
                numCodigo=0;
                set = con.createStatement();
                rs = set.executeQuery("Select * from citas where Codigo>=(Select max(Codigo) from citas);");
                if(rs.next()){
                    numCodigo = rs.getInt("Codigo");
                    numCodigo++;
                }
                rs.close();
                set.close();
            } catch (SQLException ex1) {
                System.out.println("No se ha podido contar el número de citas." + ex1);
            }
            
            try {
                set = con.createStatement();
                set.execute("INSERT INTO citas VALUES('"+fecha+"','"+hora+":"+min+":00',"+sesionTIS+","+numColegiado+","+numCodigo+")");
                set.close();
                PrintWriter out = res.getWriter();  
                res.setContentType("text/html");  
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('La cita ha sido confirmada.');");  
                out.println("</script>");
                req.getRequestDispatcher("pedirCita.jsp").forward(req, res);
                //set.close();
            } catch (SQLException ex1) {
                System.out.println("NO SE PUDO PEDIR LA CITA. " + ex1);
            }
            
        }
        //processRequest(req, res);
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
