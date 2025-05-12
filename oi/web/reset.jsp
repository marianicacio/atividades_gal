<%@page import="java.sql.*"%>


<%

                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/sistema";
                String user = "root";
                String password = "root";
                conecta = DriverManager.getConnection(url, user, password);
                //Listar os dados da tabela produto do banco de dados
                String sql = ("UPDATE vagas SET status_vagas = ? WHERE status_vagas = ?");
                st = conecta.prepareStatement(sql);
                st.setString(1,"disponivel");
                st.setString(2, "ocupada");
                st.executeUpdate();
                
                sql = "DELETE FROM veiculos";
                st = conecta.prepareStatement(sql);
                st.executeUpdate();
                
                response.sendRedirect("mapa.jsp");

%>