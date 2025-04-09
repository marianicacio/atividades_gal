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
            // Receber o código do produto e ser alterado e armazenado na variável
            String c;
            c = request.getParameter("cpf");
            Connection conecta;
            PreparedStatement st;

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/db_seunome";
            String user = "root";
            String password = "root";

            conecta = DriverManager.getConnection(url, user, password);

            // Buscar o produto pelo código recebido
            String sql = "SELECT * FROM tb_contato WHERE cpf = ?";
            st = conecta.prepareStatement(sql);  // Corrigido aqui

            // ResultSet serve para guardar aquilo que foi encontrado
            st.setString(1, c);  // Corrigido aqui para setInt
            ResultSet resultado = st.executeQuery();

            if (!resultado.next()) {
                out.print("Este produto não foi Localizado");
            } else {
        %>

        <form method="post" action="alterar.jsp">
             <input type="hidden" name="cpf" value="<%= resultado.getString("cpf") %>">
            <p>
                <label for="celular">Celular: </label>
                <input type="text" name="celular" id="celular" value="<%= resultado.getString("celular")%>">
            </p>
            <p>
                <label for="cidade">Cidade: </label>
                <input type="text" name="cidade" id="cidade" value="<%= resultado.getString("cidade")%>">
            </p>
            <p>
                <label for="ddd">DDD: </label>
                <input type="text" name="ddd" id="ddd" value="<%= resultado.getString("ddd")%>">
            </p>
            <p>
                <label for="email">Email: </label>
                <input type="email" name="email" id="email" value="<%= resultado.getString("email")%>">
            </p>
            <p>
                <label for="endereco">Endereço: </label>
                <input type="text" name="endereco" id="endereco" value="<%= resultado.getString("endereco")%>">
            </p>
            <p>
                <label for="estado">Estado: </label>
                <input type="text" name="estado" id="estado" value="<%= resultado.getString("estado")%>">
            </p>
            <p>
                <input type="submit" value="Salvar Alterações">
            </p>
        </form>

        <% }%>

    </body>
</html>