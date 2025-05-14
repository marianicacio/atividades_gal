<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styleForm.css"/>
    </head>
    <body>
        
  
        
        <%
            try {
                //Fazer a conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/sistema";
                String user = "root";
                String password = "root";
                conecta = DriverManager.getConnection(url, user, password);
                //Listar os dados da tabela produto do banco de dados
                String sql = ("SELECT numero FROM vagas WHERE status_vagas = 'disponivel'  ");
                st = conecta.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                //Enquanto não chegar no final ele vai executar
                //o que estiver dentro do while
                
              
                
                 
                String mensagem = "";
                boolean sucesso = false;

                // Verifica se o formulário foi enviado
                if (request.getMethod().equalsIgnoreCase("POST")) {
                
                    String dataHora = request.getParameter("data_hora_entrada");
                    String dataHoraFormatada = dataHora.replace("T", " ") + ":00";
                
                    int numero = Integer.parseInt(request.getParameter("numero"));
                    String placa = request.getParameter("placa").toUpperCase().trim();

                    // Regex para validar formato da placa (antigo ou Mercosul)
                    String regex = "^[A-Z]{3}-?[0-9]{4}$|^[A-Z]{3}[0-9][A-Z][0-9]{2}$";
                    Pattern pattern = Pattern.compile(regex);
                    Matcher matcher = pattern.matcher(placa);

                    if (matcher.matches()) {
            
                        sql = "INSERT INTO veiculos(placa, data_hora_entrada, valor_pago, status_veiculo) VALUES (?,?, ?, ?)";
                        st = conecta.prepareStatement(sql);
                        st.setString(1, placa);
                        st.setString(2, dataHoraFormatada);
                        st.setDouble(3, 0);
                        st.setString(4, "estacionado");
                        st.executeUpdate();
                        
                        sucesso = true;
                        
                        sql = "UPDATE vagas SET status_vagas = ? WHERE numero = ?";
                        st = conecta.prepareStatement(sql);
                        st.setString(1, "ocupada");
                        st.setInt(2, numero);
                        st.executeUpdate();
                        
                        response.sendRedirect("menu.jsp");
                        
                    } else {
                        mensagem = "❌ Placa inválida. Tente novamente.";
                    }
                }



        %>
        
         <header>
            <article>
                <div><a href="menu.jsp"><img src="Marilyllo.png" alt="alt"/></a></div>
                <nav>
                    <a href="formulario.jsp">Entrada</a>
                    <a href="#">Saida</a>
                    <a href="mapa.jsp">Mapa</a>
                    <a href="#">Relatorio</a>
                    <a href="configuracao.jsp">Configurações</a>
                </nav>
                <a href="logout.jsp">Logout</a>
            </article>
        </header>

        <form action="" method="post">
            <input type="text" name="placa" placeholder="Placa">
            <input type="datetime-local" name="data_hora_entrada" required>
            <select name="numero" id="id" required>
                <option value="first">Vagas</option>
                <%             while (rs.next()) {
                %>
                <option>  <%=rs.getString("numero")%></option>
                <%
                    }
                %>
            </select>

            <button type="submit">Entrar</button>
        </form>
            
    <%
        } catch (Exception x) {
            out.print("Mensagem de erro: " + x.getMessage());
        }
    %>
   
 
</body>
</html>