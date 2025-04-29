<%@page import="java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%

    String vaga = request.getParameter("vaga");
    
        String usuarioLogado = (String) session.getAttribute("usuario");
        
        if(usuarioLogado == null){
            response.sendRedirect("index.html");
            return;
        }
        
        

     %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header style="display: flex; flex-direction: column; align-items: center; justify-content: space-between">
            <article style="display: flex; flex-direction: column; align-items: center; gap: 30px;">
            <h1>Estacionamento!</h1>
            <nav style="display: flex; gap: 40px;">
                <a href="formulario.jsp">Entrada de Carros</a>
                <a href="#">Saida de Carros</a>
                <a href="mapa.jsp">Mapa em tempo real</a>
                <a href="#">Gerar Relatorio</a>
                <a href="configuracao.jsp">Configurações</a>
            </nav>
                <a href="logout.jsp">Logout</a>
            </article>
        </header>
        <main style="display: flex; flex-direction: column; align-items: center; gap: 50px; padding: 50px 70px">
            <h1>Vaga <%=vaga%></h1>
            <form action="verificacaoPlaca.jsp" method="post" style="display: flex; flex-direction: column; align-items: center; gap: 50px;">
                
                <input type="text" name="placa" placeholder="Digite a placa" required>
                <input type="datetime-local" name="data_hora_entrada" required>
                <input type="hidden" name="numero" value="<%=vaga%>">
                <button type="submit">Entrar</button>
                
            </form>
        </main>
    </body>
</html>
