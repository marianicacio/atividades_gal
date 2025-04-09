<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exckusão</title>
    </head>
    <body>
        <%
            String cpf;
            cpf=request.getParameter("cpf");
            try {
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/db_seunome";
            String user="root";
            String password="root";
            conecta=DriverManager.getConnection(url,user,password);
            
            String sql="DELETE FROM tb_contato WHERE cpf=?";
            st=conecta.prepareStatement(sql);
            st.setString(1, cpf);
            int resultado=st.executeUpdate(); //executando o comando delete
            if (resultado==0) {
                out.print("Este contato não está cadastrado no banco");
            } else {
                out.print("O contato de cpf = " + cpf + ", foi excluir com sucesso");
            }
            } catch (Exception error) {
                String mensagemErro = error.getMessage();
                out.print("Entre em contato com a administrador e informe o erro");
                
            }
            %>
    </body>
</html>
