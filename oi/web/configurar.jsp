<%@page import="java.sql.*"%>


<%
    
    Connection conecta;
    PreparedStatement st;
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/sistema";
    String user = "root";
    String password = "root";
    conecta = DriverManager.getConnection(url, user, password);
    
    
    try {
    
        Double valor_primeira_hora = Double.parseDouble(request.getParameter("valor_primeira_hora"));
        Double valor_hora_adicional = Double.parseDouble(request.getParameter("valor_hora_adicional"));
        int vagas_totais = Integer.parseInt(request.getParameter("vagas_totais"));
    
        String sql = "UPDATE configuracoes SET valor_primeira_hora = ?, valor_hora_adicional = ?, vagas_totais = ? WHERE id_config = ?";
        st = conecta.prepareStatement(sql);
        st.setDouble(1, valor_primeira_hora);
        st.setDouble(2, valor_hora_adicional);
        st.setInt(3, vagas_totais);
        st.setInt(4, 1);
        st.executeUpdate();
        
        response.sendRedirect("mapa.jsp");
    
    } catch (Exception x ){
        
        out.print("Erro ao configurar! Mensagem de Erro: " + x.getMessage());
    
    }


%>