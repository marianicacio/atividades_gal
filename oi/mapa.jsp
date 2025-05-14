<%@page import="java.sql.*"%>



<%

    String usuarioLogado = (String) session.getAttribute("usuario");

    if (usuarioLogado == null) {
        response.sendRedirect("index.html");
        return;
    }

    Connection conn = null;
    PreparedStatement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema", "root", "root");

        String sql = "SELECT * FROM vagas";
        st = conn.prepareStatement(sql);
        rs = st.executeQuery();

%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styleMapa.css"/>
    </head>
    <body>
        <header>
            <a class="reset" href="reset.jsp">Resetar Estacionamento.</a>
            <article>
                <div><a href="menu.jsp"><img src="Marilyllo.png" alt="logo estacionamento"/></a></div>
                <nav>
                    <a href="formulario.jsp">Entrada</a>
                    <a href="#">Saída</a>
                    <a href="mapa.jsp">Mapa</a>
                    <a href="#">Relatório</a>
                    <a href="configuracao.jsp">Configurações</a>
                </nav>
                <a href="logout.jsp">Logout</a>
            </article>
            <a class="reset" href="reset.jsp">Resetar Estacionamento.</a>
        </header>
        
        
        
        <main style="display: flex; justify-content: center; flex-wrap: wrap; gap: 50px; padding: 50px 70px">
            <%            while (rs.next()) {
                    if (rs.getString("status_vagas").equals("disponivel")) {
            %>
            <form action="cinema.jsp" method="post">

                <input type="hidden" name="vaga" value="<%=rs.getString("numero")%>">
                <button type="submit" style="background-color: #065732; cursor: pointer; width: 100px; height: 100px; display: flex; justify-content: center; flex-direction: column; align-items: center; border: 1px solid white; color: white;">
                    <p>Vaga <%=rs.getString("numero")%></p>
                    <p>Disponível!</p>
                </button>

            </form>                
            <%
            } else {
            %>

            <form action="saidaform.jsp" method="post">

                <input type="hidden" name="vaga" value="<%=rs.getString("numero")%>">
                <button type="submit" style="background-color: #830018; cursor: pointer; width: 100px; height: 100px; display: flex; justify-content: center; flex-direction: column; align-items: center; border: 1px solid white; color: white;">
                    <p>Vaga <%=rs.getString("numero")%></p>
                    <p>Ocupada!</p>
                </button>

            </form>  
            <%
                    } // fim do else
                } // fim do while
            %>
        </main>
    </body>


    <%
            // fim do else
            conn.close();
        } catch (Exception e) {
            out.println("<p>Erro ao listar produtos: " + e.getMessage() + "</p>");
        }

    %>
</html>