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
            //receber dados digitados do formulario cadpro

            int ddd, celular, mes_nascimento, cpf;
            String first_name, last_name, endereco, estado, email, cidade;

            ddd = Integer.parseInt(request.getParameter("ddd"));
            celular = Integer.parseInt(request.getParameter("celular"));
            mes_nascimento = Integer.parseInt(request.getParameter("mes_nasc"));
            cpf = Integer.parseInt(request.getParameter("cpf"));
            first_name = request.getParameter(("first_name"));
            last_name = request.getParameter(("last_name"));
            endereco = request.getParameter(("endereco"));
            estado = request.getParameter(("estado"));
            cidade = request.getParameter(("cidade"));
            email = request.getParameter(("email"));
            //Fazer a conexão com o banco de dados

            try {
                Connection conecta;
                PreparedStatement st; //Esse objeto permite enviar vários
                // comandos sql como um grupo unico para um banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); //este método é usado para que o servidor 
                //de aplicação faça o registro do driver do banco
                String url = "jdbc:mysql://localhost:3306/db_seunome";
                String user = "root";
                String password = "root";

                conecta = DriverManager.getConnection(url, user, password);

                String sql = ("INSERT INTO produto VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                st = conecta.prepareStatement(sql);
                st.setString(1, first_name);
                st.setString(2, last_name);
                st.setString(3, endereco);
                st.setString(4, cidade);
                st.setString(5, estado);
                st.setInt(6, ddd);
                st.setInt(7, celular);
                st.setString(8, email);
                st.setInt(9, mes_nascimento);
                st.setInt(10, cpf);
                st.executeUpdate(); //executar a instrução INSERT
                out.print("<p style= 'color: green; font-size:25px'>Funcionário cadastrado com sucesso...</p>");
            } catch (Exception x) {
                String erro = x.getMessage();
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color: purple; font-size25px'>Este funcionário está cadastrado</p>");
                } else {
                    out.print("<p style='color: red; font-size:25px'>Mensagem de erro: " + erro + "</p>");

                }
            }

        %>
    </body>
</html>
