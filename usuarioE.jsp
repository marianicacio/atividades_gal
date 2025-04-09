<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>minha pica</title>
    </head>
    <body>
        <%
            String usuario, senha;
            usuario = request.getParameter("usuario");
            senha = request.getParameter("senha");


            try {
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/db_login";
                String user = "root";
                String password = "maria";

                conecta = DriverManager.getConnection(url, user, password);
                String sql = ("SELECT * FROM tb_login WHERE usuario = ? AND senha = ?");
                st = conecta.prepareStatement(sql);
                st.setString(1, usuario);
                st.setString(2, senha);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    response.sendRedirect("cadastrar.html");
                } else {
                    response.sendRedirect("index.html");
                }
            } catch (Exception x) {
                out.print("Mensagem de erro: " + x.getMessage());
            }
        %>
    </body>
</html>

