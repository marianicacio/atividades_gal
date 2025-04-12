<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles_cadastrar.css"/>
    </head>
    <body>
        <article>

            <%!
                public boolean validarCPF(String cpfInput) {
                    if (cpfInput == null || cpfInput.length() != 11 || cpfInput.matches("(\\d)\\1{10}")) {
                        return false;
                    }

                    try {
                        int soma = 0;
                        for (int i = 0; i < 9; i++) {
                            soma += Character.getNumericValue(cpfInput.charAt(i)) * (10 - i);
                        }
                        int digito1 = (soma * 10) % 11;
                        if (digito1 == 10) {
                            digito1 = 0;
                        }
                        if (digito1 != Character.getNumericValue(cpfInput.charAt(9))) {
                            return false;
                        }

                        soma = 0;
                        for (int i = 0; i < 10; i++) {
                            soma += Character.getNumericValue(cpfInput.charAt(i)) * (11 - i);
                        }
                        int digito2 = (soma * 10) % 11;
                        if (digito2 == 10) {
                            digito2 = 0;
                        }
                        if (digito2 != Character.getNumericValue(cpfInput.charAt(10))) {
                            return false;
                        }

                        return true;
                    } catch (Exception e) {
                        return false;
                    }
                }
            %>

            <%
                //receber dados digitados do formulario cadpro

                int ddd, celular, mes_nascimento;
                String primeiro_nome, ultimo_nome, endereco, estado, email, cidade, cpf;

                ddd = Integer.parseInt(request.getParameter("ddd"));
                celular = Integer.parseInt(request.getParameter("celular"));
                mes_nascimento = Integer.parseInt(request.getParameter("mes_nascimento"));
                cpf = request.getParameter("cpf");
                primeiro_nome = request.getParameter("primeiro_nome");
                ultimo_nome = request.getParameter("ultimo_nome");
                endereco = request.getParameter("endereco");
                estado = request.getParameter("estado");
                cidade = request.getParameter("cidade");
                email = request.getParameter("email");
                //Fazer a conexão com o banco de dados

                String cpfInput = request.getParameter("cpf").replaceAll("\\D", "");
                String dddStr = request.getParameter("ddd");

                boolean dddValido = false;
                boolean cpfValido = validarCPF(cpfInput);

                if (!cpfValido) {
                    out.println("<p style='color:red;'>CPF inválido! Verifique os dígitos.</p>");
                    out.println("<a href='cadastrar.html'>Voltar</a>");
                    return;
                }

                try {
                    

                    Class.forName("com.mysql.cj.jdbc.Driver"); //este método é usado para que o servidor 
                    //de aplicação faça o registro do driver do banco
                    String url = "jdbc:mysql://localhost:3306/db_seunome";
                    String user = "root";
                    String password = "root";
                    
                    Connection conecta;
                    conecta = DriverManager.getConnection(url, user, password);
                    
                    PreparedStatement st;
                    //Esse objeto permite enviar vários
                    // comandos sql como um grupo unico para um banco de dados
                    // Verificar se DDD existe
                    PreparedStatement checkDdd = conecta.prepareStatement("SELECT * FROM tb_ddd WHERE ddd = ?");
                    checkDdd.setString(1, dddStr);
                    ResultSet rs = checkDdd.executeQuery();
                    if (rs.next()) {
                        dddValido = true;
                    }
                    rs.close();
                    checkDdd.close();

                    if (!dddValido) {
                        out.println("<p style='color:red;'>DDD inválido!</p>");
                        out.println("<a href='cadastrar.html'>Voltar</a>");
                        conecta.close();
                        return;
                    }

                    String sql = ("INSERT INTO tb_contato(primeiro_nome, ultimo_nome, endereco, cidade, estado, ddd, celular, email, mes_nascimento, CPF ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    st = conecta.prepareStatement(sql);
                    st.setString(1, primeiro_nome);
                    st.setString(2, ultimo_nome);
                    st.setString(3, endereco);
                    st.setString(4, cidade);
                    st.setString(5, estado);
                    st.setInt(6, ddd);
                    st.setInt(7, celular);
                    st.setString(8, email);
                    st.setInt(9, mes_nascimento);
                    st.setString(10, cpf);
                    out.print("<p style= 'color: black; font-size:25px'>Contato cadastrado com sucesso...</p>"
                            + "<section style='display: flex; gap: 20px' > <a href='lista.jsp' >Listar os contatos<a/>" + "<a href='consultar.html'>Consultar<a/>" + "<a href='editar.html'>Editar<a/>" + "<a href='excluir.html'>Exclusão<a/><section/>");
                } catch (Exception x) {
                    String erro = x.getMessage();
                    if (erro.contains("Duplicate entry")) {
                        out.print("<p style='color: purple; font-size25px'>Este funcionário está cadastrado</p>");
                    } else {
                        out.print("<p style='color: red; font-size:25px'>Mensagem de erro: " + erro + "</p>");

                    }
                }

            %>
        </article>
    </body>
</html>
