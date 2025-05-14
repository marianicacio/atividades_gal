<%@page import="java.sql.*" %> 

<%
    
        String usuarioLogado = (String) session.getAttribute("usuario");
        
        if(usuarioLogado == null){
            response.sendRedirect("index.html");
            return;
        }
        
        int numero = Integer.parseInt(request.getParameter("vaga"));
        String dataHoraFormatada = "";
        String dataHora = "";
        String placa = "";
        
        try {
        
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/sistema";
            String user = "root";
            String password = "root";
            conecta = DriverManager.getConnection(url, user, password);
            
            String sql = "SELECT * FROM veiculos WHERE id_vaga = ?";
            st = conecta.prepareStatement(sql);
            st.setInt(1, numero);
            ResultSet rs = st.executeQuery();
            
            if(rs.next()){
            
                placa = rs.getString("placa");
                dataHora = rs.getString("data_hora_entrada");
                dataHoraFormatada = dataHora.replace("T", " ") + ":00";
                
            }
            
            
        
        }catch (Exception x) {
            out.print("Mensagem de Erro: " + x.getMessage());
        }
        

     
        
        
     %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header style="display: flex; flex-direction: column; align-items: center; justify-content: space-between">
            <article style="display: flex; flex-direction: column; align-items: center; gap: 30px;">
            <a href="menu.jsp"><h1>Estacionamento!</h1></a>
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
        
        <main style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 50vh;">
            <h1><%=placa%></h1>
            <form action="entresaida.jsp" style="align-items: center; display: flex; flex-direction: column">
                <h1>Saida de Veiculos</h1>
                
                <input hidden value="<%=placa%>" name="placa">
                <input hidden value="<%=numero%>" name="numero">
                <label>Horario de Entrada</label>
                <p><%=dataHora%></p>
                <label>Horario de Saida</label>
                <input type="datetime-local" name="data_hora_saida" placeholder="horario de saida" min="<%=dataHora%>" required>
                <input value="Sair" type="submit">
                
            </form>

        </main>
    </body>
</html>