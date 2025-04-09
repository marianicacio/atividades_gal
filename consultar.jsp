<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>consultar</title>
    </head>
    <body>
        <%
            //Recebe o nome do produto digitado no formulario conpro.html
            String n;

            n = request.getParameter("nome");

            try {
                //fazer a conexão com o bdados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3306/db_seunome";
                String user = "root";
                String password = "root";

                conecta = DriverManager.getConnection(url, user, password);
                //lista o dado da tabela produto do banco de dados
                String sql = ("SELECT * FROM tb_contato WHERE primeiro_nome LIKE ?");

                st = conecta.prepareStatement(sql);

                //na linha abaixo estamos dizendo o que vai dentro do ponto de ?
                //que será concatenado com % para poder pegar qualquer
                //parte do nome do produto salvo no banco
                st.setString(1, "%" + n + "%");
                //ResultSet serve para guarda aquilo que é traduzido no banco de dados
                ResultSet rs = st.executeQuery();
                //enquanto não chegar no final do banco de dados ele vai executar
                //o que estiver dentro do while vamos montar uma tabela html
                //criando o titulo da tabela e encerrar o codigo java
%>
        <table>
            <tr>
                <th>Endereço</th>
                <th>Cidade</th>
                <th>DDD</th>
                <th>Celular</th>
                <th>E-mail</th>
                <th>CPF</th>
            </tr>
            
            <%
                while (rs.next()) {
                %>
                
                <!<!-- finalizamos o codigo java acima e agora vamos criar uma tabela html para 
                mostrar os dados recuoperados do banco de dados-->
                
                <tr>
                    <td><%=rs.getString("endereco")%></td>
                    <td><%=rs.getString("cidade")%></td>
                    <td><%=rs.getInt("ddd")%></td>
                    <td><%=rs.getInt("celular")%></td>
                     <td><%=rs.getString("email")%></td>
                      <td><%=rs.getString("cpf")%></td>
                </tr>
                <%
                    }
                    %>
        </table>
        <%
            } catch (Exception x) {
            out.print ("Mensagem de erro: " + x.getMessage());
            }
        %>
    </body>
</html>
