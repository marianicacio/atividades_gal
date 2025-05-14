<%@page import="java.sql.*"%>

<%

    String dataHora = request.getParameter("data_hora_saida");
    String dataHoraFormatada = dataHora.replace("T", " ") + ":00";
    int numero = Integer.parseInt(request.getParameter("numero"));
    
    String usuarioLogado = (String) session.getAttribute("usuario");
    int id_usuario = 0, id_veiculo = 0;
        
        if(usuarioLogado == null){
            response.sendRedirect("index.html");
            return;
        }
    
    String placa = request.getParameter("placa");
    
    try {
    
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema", "root", "root");

        String sql = "SELECT * FROM usuario WHERE login = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, usuarioLogado);
        ResultSet rs = st.executeQuery();
        
        if(rs.next()){
            id_usuario = rs.getInt("id_usuario");
        }
        
        sql = "SELECT * FROM veiculos WHERE placa = ?";
        st = conn.prepareStatement(sql);
        st.setString(1, placa);
        rs = st.executeQuery();
        
        if(rs.next()){
            id_veiculo = rs.getInt("id_veiculo");
        }
        
        
        sql = "INSERT INTO movimentacoes(id_usuario, id_veiculo, tipo_movimentacao, data_hora) VALUES (?,?,?,?)";
        st = conn.prepareStatement(sql);
        st.setInt(1, id_usuario);
        st.setInt(2, id_veiculo);
        st.setString(3, "saida");
        st.setString(4, dataHoraFormatada);
        st.executeUpdate();
        
        sql = "UPDATE vagas SET status_vagas = ? WHERE numero = ?";
        st = conn.prepareStatement(sql);
        st.setString(1, "disponivel");
        st.setInt(2, numero);
        st.executeUpdate();
        
        sql = "UPDATE veiculos SET status_veiculo = ?, data_hora_saida = ? WHERE placa = ?";
        st = conn.prepareStatement(sql);
        st.setString(1, "retirado");
        st.setString(2, dataHoraFormatada);
        st.setString(3, placa);
        st.executeUpdate();
        
        response.sendRedirect("mapa.jsp");
        
        
    
    } catch (Exception x) {
        out.print("Mensagem de Erro: " + x.getMessage());
    }




%>