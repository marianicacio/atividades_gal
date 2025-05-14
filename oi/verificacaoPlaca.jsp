<%@page import="java.sql.*" %>
<%@page import="java.util.regex.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/sistema";
        String user = "root";
        String password = "root";
        conecta = DriverManager.getConnection(url, user, password);

        
            String dataHora = request.getParameter("data_hora_entrada");
            String dataHoraFormatada = dataHora.replace("T", " ") + ":00";
            String usuario = (String) session.getAttribute("usuario");

            int numero = Integer.parseInt(request.getParameter("numero"));
            String placa = request.getParameter("placa").toUpperCase().trim();

            String regex = "^[A-Z]{3}-?[0-9]{4}$|^[A-Z]{3}[0-9][A-Z][0-9]{2}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(placa);

            if (matcher.matches()) {
                String sql = "INSERT INTO veiculos(placa, data_hora_entrada, valor_pago, status_veiculo, id_vaga) VALUES (?, ?, ?, ?, ?)";
                st = conecta.prepareStatement(sql);
                st.setString(1, placa);
                st.setString(2, dataHoraFormatada);
                st.setDouble(3, 0);
                st.setString(4, "estacionado");
                st.setInt(5, numero);
                st.executeUpdate();

                sql = "UPDATE vagas SET status_vagas = ? WHERE numero = ?";
                st = conecta.prepareStatement(sql);
                st.setString(1, "ocupada");
                st.setInt(2, numero);
                st.executeUpdate();
                
                sql = "SELECT * FROM usuario WHERE login = ?";
                st = conecta.prepareStatement(sql);
                st.setString(1, usuario);
                ResultSet rs = st.executeQuery();
                
                int id_usuario = 0;
                
                if (rs.next()) {
                    id_usuario = rs.getInt("id_usuario");
                }
               
                sql = "SELECT * FROM veiculos WHERE placa = ?";
                st = conecta.prepareStatement(sql);
                st.setString(1, placa);
                rs = st.executeQuery();
                
                int id_veiculo = 0;
                
                if (rs.next()){
                            id_veiculo = rs.getInt("id_veiculo");
                }
                
                
                
                sql = "INSERT INTO movimentacoes(id_usuario, id_veiculo, tipo_movimentacao, data_hora) VALUES (?, ?, ?, ?);";
                st = conecta.prepareStatement(sql);
                st.setInt(1, id_usuario);
                st.setInt(2, id_veiculo);
                st.setString(3, "entrada");
                st.setString(4, dataHoraFormatada);
                st.executeUpdate();
                
                
                response.sendRedirect("mapa.jsp");
            } else {
                
                out.print("\u274C Placa inv\u00e1lida. Tente novamente.");
            }
       
    } catch (Exception x) {
        out.print("Mensagem de erro: " + x.getMessage());
    }
%>