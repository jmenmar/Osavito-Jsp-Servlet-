<%-- 
    Document   : ConsultarCitasPaciente
    Created on : 26-dic-2017, 12:12:05
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
        <script type="text/javascript" src="js/Sesion.js"></script>
        <script type="text/javascript" src="js/AnulacionCita.js"></script>
        <title>Mis citas</title>
    </head>
    <body background="img/background.png" onLoad="mostrarDatosUsuario()">
        <h1><img src="./img/osavitoM.png" alt="OsaVito"></h1>
        <h2>
            Bienvenid@
            <input type="button" value="Cerrar sesión" style="float: right;" onclick="logout();"/>  
            <input type="button" value="Volver" style="float: right;" onclick="location='MenuPaciente.html'"/> </br>
            TIS:<span id="numeroT"></span></br>
        </h2>
            <form name="consultarCitas" id="consultarCitas" action="eliminarCita" method="post">
                <%!
                    private Connection con;
                    private Statement set;
                    private ResultSet rs;
                    String fechaC,horaC,nombreCol,tipoSan;
                    int codigo,contadorPendientes;

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
                <h3>
                    Citas expiradas:
                    <%
                        HttpSession s = request.getSession(true);
                        String TIS =(String) s.getAttribute("tis");
                        
                        set = con.createStatement();
                        rs = set.executeQuery("SELECT * FROM citas inner join sanitarios on citas.NumColegiado=sanitarios.NumColegiado WHERE TIS="+TIS+" AND ((fecha<(Select CURDATE())) OR (fecha=(Select CURDATE()) AND Hora<(Select CURTIME()))) ORDER BY fecha,hora;");
                        while (rs.next()) {
                            fechaC = rs.getString("Fecha");
                            horaC = rs.getString("Hora");
                            nombreCol = rs.getString("Nombre");
                            tipoSan = rs.getString("Tipo");
                            
                    %>
                    <p></p><%=fechaC%> <%=horaC%> - <%=tipoSan%> - <%=nombreCol%>
                    <%
                        }
                        rs.close();
                        set.close();
                    %>
                    <p></p>Citas pendientes: 
                    <%
                        
                        contadorPendientes=0;
                        set = con.createStatement();
                        rs = set.executeQuery("SELECT * FROM citas inner join sanitarios on citas.NumColegiado=sanitarios.NumColegiado WHERE TIS="+TIS+" AND ((fecha>(Select CURDATE())) OR (fecha=(Select CURDATE()) AND Hora>=(Select CURTIME()))) ORDER BY fecha,hora;");
                        while (rs.next()) {
                            fechaC = rs.getString("Fecha");
                            horaC = rs.getString("Hora");
                            nombreCol = rs.getString("Nombre");
                            tipoSan = rs.getString("Tipo");
                            codigo = rs.getInt("Codigo");
                            contadorPendientes++;
                    %>
                    <p></p><input type="radio" name="rad" value="<%=codigo%>" checked=""/><%=fechaC%> <%=horaC%> - <%=nombreCol%> (<%=tipoSan%>)
                    <%
                        }
                        rs.close();
                        set.close();
                    %>
                    <p></p>
                    <p></p>
                    <% if(contadorPendientes!=0){%>
                        <input type="submit" value="Anular cita" onClick="confirmar();"></input>
                    <%}%>
                </h3>
                </form>
        <footer>Copyright &copy;OsaVito03</footer>
    </body>
</html>
