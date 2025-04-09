
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
            try {
                //Fazer a conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/db_seunome";
                String user = "root";
                String password = "root";
                conecta = DriverManager.getConnection(url, user, password);
                //Listar os dados da tabela produto do banco de dados
                String sql = ("SELECT * FROM tb_contato");
                st = conecta.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                //Enquanto não chegar no final ele vai executar
                //o que estiver dentro do while

        %>
        <table>
            <tr>
                <th>Primeiro Nome</th>
                <th>Ultimo Nome</th>
                <th>Endereço</th>
                <th>Cidade</th>
                <th>Estado</th>
                <th>DDD</th>
                <th>Celular</th>
                <th>Email</th>
                <th>Mês Nascimento</th>
                <th>CPF</th>
                <th>Exclusão</th>

            </tr>
            <%             while (rs.next()) {
            %>
            <!-- Finalizei o codigo java acima agora vou criar o corpo da tabela html para
            mostrar os dados trazidos do Banco de dados-->

            <tr>
                <td>
                    <%=rs.getString("primeiro_nome")%>
                </td>
                <td>
                    <%=rs.getString("ultimo_nome")%>
                </td>
                <td>
                    <%=rs.getString("endereco")%>
                </td>
                <td>
                    <%=rs.getString("cidade")%>
                </td>
                 <td>
                    <%=rs.getString("estado")%>
                </td>
                  <td>
                    <%=rs.getString("ddd")%>
                </td>
                <td>
                    <%=rs.getString("celular")%>
                </td>
                <td>
                    <%=rs.getString("email")%>
                </td>
                <td>
                    <%=rs.getString("mes_nascimento")%>
                </td>
                 <td>
                    <%=rs.getString("cpf")%>
                </td>
              
                
            </tr>
            <%
                }
            %>
        </table>
        <%
            } catch (Exception x) {
                out.print("Mensagem de erro: " + x.getMessage());
            }
        %>
    </body>
</html>