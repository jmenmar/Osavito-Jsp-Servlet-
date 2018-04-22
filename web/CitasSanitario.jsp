<%-- 
    Document   : CitasSanitario
    Created on : 26-dic-2017, 16:42:18
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
        <title>Consulta de citas</title>
    </head>
    <body background="img/background.png" onLoad="mostrarDatosSanitario()">
        <h1><img src="./img/osavitoM.png" alt="OsaVito"></h1>
        <h2>
            Bienvenid@ 
            <input type="button" value="Salir" style="float: right;" onclick="logout();"/> </br>
            Número Colegiado: <span id="numeroCol"></span></br>
        </h2>
            <form name="selectFecha" action="citasDelSanitario" method="post">
                <h3>
                    Elegir día: <input type="date" name="fecha" id="fecha">
                    <p></p><input type="submit" value="Ver citas"></input>
                </h3>
            </form>
    </body>
</html>
