<%-- 
    Document   : pedirCita
    Created on : 26-dic-2017, 14:33:58
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
        <script type="text/javascript" src="js/ControlesCita.js"></script>
        <script type="text/javascript" src="js/ControlarHoraCita.js"></script>
        <title>Pedir cita</title>
    </head>
    <body>
    <body background="img/background.png" onload="mostrarDatosUsuario(); minimoHoy();">
        <h1><img src="./img/osavitoM.png" alt="OsaVito"></h1>
        <h2>
            <%!
                private Connection con;
                private Statement set;
                private ResultSet rs;
                int numColegiado;
                String nombreSan,nombrePac;

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
            Bienvenid@ 
            <%
                HttpSession s1 = request.getSession(true);
                String numTis =(String) s1.getAttribute("tis");

                set = con.createStatement();
                rs = set.executeQuery("SELECT * FROM pacientes WHERE TIS="+numTis+"");
                while (rs.next()) {
                    nombrePac = rs.getString("Nombre");
                }
                    rs.close();
                    set.close();
            %>
            <%=nombrePac%>
            <input type="button" value="Cerrar sesión" style="float: right;" onclick="logout();"/>  
            <input type="button" value="Volver" style="float: right;" onclick="location='MenuPaciente.html'"/> </br>
            TIS:<span id="numeroT"></span></br>
        </h2>
            <form id="pedirCita" name="pedirCita" action="nuevaCita" method="post">
                <h3>
                PEDIR CITA</br></br>
                Elige Sanitario:
                <select name="sanitario" id="sanitario">
                    <%
                        HttpSession s = request.getSession(true);
                        String TIS =(String) s.getAttribute("tis");
                        
                        set = con.createStatement();
                        rs = set.executeQuery("SELECT * FROM pacsani inner join sanitarios ON pacsani.NumColegiado=sanitarios.NumColegiado WHERE TIS="+TIS+"");
                        while (rs.next()) {
                            nombreSan = rs.getString("Nombre");
                            numColegiado = rs.getInt("NumColegiado");
                    %>
                    <option value="<%=numColegiado%>"><%=nombreSan%></option>
                    <%
                        }
                        rs.close();
                        set.close();
                    %>  
                </select><p></p>
                Fecha: <input type="date" name="fecha" id="fecha" required=""/></br></br>
                Horario: 
                    <datalist id="hora">
                        <option value="09" label=" ">
                        <option value="10" label=" ">
                    </datalist>
                    <input type="tel" name="hora" id="selecthora" list="hora" placeholder="Hora" required=""/>
                    <datalist id="min">
                        <option value="00" label=" ">
                        <option value="15" label=" ">
                        <option value="30" label=" ">
                        <option value="45" label=" ">
                    </datalist>
                    <input type="tel" name="min" id="selectmin" list="min" placeholder="Min" required=""/></br></br></br>
                    <input type="button" value="Confirmar" onClick="noFindes();"/>
                    <input type="reset" value="Borrar"/>
                </h3>
                </form>
        <footer>Copyright &copy;OsaVito03</footer>
    </body>
    </body>
</html>
