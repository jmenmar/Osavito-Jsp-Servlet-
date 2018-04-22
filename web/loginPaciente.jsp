<%-- 
    Document   : loginPaciente
    Created on : 26-dic-2017, 10:53:45
    Author     : JAVIER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/index.css" type="text/css" media="all" />
        <link rel="shortcut icon" href="img/favicon.ico"/>
        <title>JSP Page</title>
    </head>
    <body background="img/background.png">
        <h1><img src="./img/osavitoM.png" alt="OsaVito"></h1>
        <form name="loginAdmin" action="loginP" method="post">
            <center>TIS: <input type="number" name="tislogin" id="tislogin" min="1" placeholder="Número de la TIS" required=""/></center></br>
            <center>FechaNacimiento: <input type="date" name="fecha" min="1990-01-01" max="2017-11-20" id="fecha" required=""/></center></br>
            <center><button type="submit">Login</button> </center></br></br></br>
            <a href="index.html">< Volver</a>
            
        </form>
        <footer>Copyright &copy;OsaVito03</footer>
    </body>
</html>
