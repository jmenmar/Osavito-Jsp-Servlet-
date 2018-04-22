<%-- 
    Document   : ConsultarCitasSanitario
    Created on : 27-dic-2017, 15:00:00
    Author     : JAVIER
--%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/sesion.css" type="text/css" media="all" />
        <link rel="shortcut icon" href="img/favicon.ico"/> 
        <script type="text/javascript" src="js/SesionSanitario.js"></script>
        <title>Mis citas</title>
    </head>
    <body background="img/background.png" onLoad="mostrarDatosSanitario()">
        <h1><img src="./img/osavitoM.png" alt="OsaVito"></h1>
        <h2>
            Bienvenid@ 
            <input type="button" value="Cerrar Sesión" style="float: right;" onclick="logout();"/>
            <input type="button" value="Volver" style="float: right;" onclick="location='CitasSanitario.jsp'"/></br>
            Número Colegiado: <span id="numeroCol"></span></br>
        </h2>
        <h3>
            <%!
                private Connection con;
                    private Statement set;
                    private ResultSet rs;
                    String hora;
                    int tis;
                    String nombrePac;

                    public void jspInit() {
                        String sURL = "jdbc:mysql://localhost/bdosavito03b";
                        String userName = "root";
                        String password = "root";
                        System.out.println("Entrando en el init()...");
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

                    };

                    public void jspDestroy() {
                        System.out.println("Entrando en el destroy()...");
                        try {
                            con.close();
                            System.out.println("Conexión cerrada.");
                        } catch (SQLException ex5) {
                             System.out.println("Error en el destroy " + ex5);                    
                        }
                        super.destroy();
                    };
            %>
            Citas del día:
            <%
            String st = request.getParameter("fecha");
            %>
            <%=st%>
            <p></p>
            <table border=0>
            <tr><td><b> Hora </b></td><td><b> TIS </b></td><td><b> Nombre </b></td></tr>
            <%
                HttpSession s = request.getSession(true);
                String numColegiado =(String) s.getAttribute("numCol");
                        
                set = con.createStatement();
                rs = set.executeQuery("SELECT * FROM citas inner join pacientes ON citas.TIS=pacientes.TIS WHERE NumColegiado="+numColegiado+" AND Fecha='"+st+"'");
                while (rs.next()) {
                    hora = rs.getString("Hora");
                    tis = rs.getInt("TIS");
                    nombrePac = rs.getString("Nombre");
            %>
            <tr><td> <%=hora%> </td><td> <%=tis%> </td><td> <%=nombrePac%> </td></tr>
            <%
                }
                rs.close();
                set.close();
            %> 
        </h3>
    </body>
</html>
