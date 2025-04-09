<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
    String celular, ddd, endereco, estado, email, cidade, cpf;

    cpf = request.getParameter("cpf");
    

    celular = request.getParameter("celular");
    ddd = request.getParameter("ddd");
    endereco = request.getParameter("endereco");
    estado = request.getParameter("estado");
    email = request.getParameter("email");
    cidade = request.getParameter("cidade");

    Connection conecta; 
    PreparedStatement st;
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/db_seunome";
    String user = "root";
    String password = "root";

    conecta = DriverManager.getConnection(url, user, password);
    String sql = "UPDATE tb_contato SET celular=?, ddd=?, endereco=?, estado=?, email=?, cidade=? WHERE cpf=?";
    st = conecta.prepareStatement(sql);

    st.setString(1, celular);
    st.setString(2, ddd);
    st.setString(3, endereco);
    st.setString(4, estado);
    st.setString(5, email);
    st.setString(6, cidade);
    st.setString(7, cpf);

    int linhasAfetadas = st.executeUpdate();

    if (linhasAfetadas > 0) {
        out.print("✅ Os dados foram alterados com sucesso. CPF: " + cpf);
    } else {
        out.print("⚠ Nenhum dado alterado. Verifique se o CPF está correto: " + cpf);
    }
%>

    </body>
</html>
