/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
public class loginPaciente extends HttpServlet {

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
    String cad,cad2;
    
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
            out.println("<title>Servlet loginPaciente</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginPaciente at " + request.getContextPath() + "</h1>");
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
        
        String tis = (String) req.getParameter("tislogin");
        s.setAttribute("tis", tis);
        
        String fechaN = (String) req.getParameter("fecha");
        s.setAttribute("fechaNac", fechaN);
        
        boolean valido = false;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM pacientes");
            while (rs.next()) {
                cad = rs.getString("TIS");
                cad2 = rs.getString("FechaNac");
                cad = cad.trim();
                cad2 = cad2.trim();
                if (cad.compareTo(tis.trim()) == 0 && cad2.compareTo(fechaN.trim()) == 0) {
                    valido = true;
                }
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
            System.out.println("No puede leer tabla pacientes. " + ex1);
        }
        try {
            set = con.createStatement();
            if (valido) {
                req.getRequestDispatcher("MenuPaciente.html").forward(req, res);
            } else {
                PrintWriter out = res.getWriter();  
                res.setContentType("text/html");  
                out.println("<script type=\"text/javascript\">");  
                out.println("alert('Datos incorrectos.');");  
                out.println("window.location = \"loginPaciente.html\";"); 
                out.println("</script>");
                //req.getRequestDispatcher("loginPaciente.html").forward(req, res);
            }
            rs.close();
            set.close();
        } catch (SQLException ex2) {
            System.out.println("ERROR EN EL LOGIN" + ex2);
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
