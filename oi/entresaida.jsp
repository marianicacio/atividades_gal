<%@page import="java.sql.*" %>
<%@page import="java.time.Duration" %>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>

<%
    double valorFinal = 0.0;
    long horasTotais = 0L;
    long minutos = 0L;

    String dataHoraSaida = request.getParameter("data_hora_saida");
    String dataHoraEntrada = "";
    int numero = Integer.parseInt(request.getParameter("numero"));
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String dataHoraSaidaFormatada = dataHoraSaida.replace("T", " ") + ":00";
    LocalDateTime horaSaida = LocalDateTime.parse(dataHoraSaidaFormatada, formatter);

    String usuarioLogado = (String) session.getAttribute("usuario");
    int id_usuario = 0, id_veiculo = 0;

    if (usuarioLogado == null) {
        response.sendRedirect("index.html");
        return;
    }

    String placa = request.getParameter("placa");

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sistema", "root", "root");

        String sql = "SELECT * FROM veiculos WHERE placa = ?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, placa);
        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            dataHoraEntrada = rs.getString("data_hora_entrada");
        }

        LocalDateTime horaEntrada = LocalDateTime.parse(dataHoraEntrada, formatter);

        Duration duracao = Duration.between(horaEntrada, horaSaida);

        // Pega quantos minutos ou horas
        minutos = duracao.toMinutes();
        horasTotais = (long) Math.ceil(minutos / 60.0);

        //variaveis de preco
        double precoPrimeiraHora = 0;
        double precoHoraAdicional = 0;

        sql = "SELECT * FROM configuracoes";
        st = conn.prepareStatement(sql);
        rs = st.executeQuery();

        if (rs.next()) {
            precoPrimeiraHora = Double.parseDouble(rs.getString("valor_primeira_hora"));
            precoHoraAdicional = Double.parseDouble(rs.getString("valor_hora_adicional"));
        }

        if (horasTotais < 1) {
            valorFinal = precoPrimeiraHora;
        } else {
            valorFinal = precoPrimeiraHora + (precoHoraAdicional * (horasTotais - 1));
        }

    } catch (Exception x) {
        out.print("Erro: " + x.getMessage());
    }

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styleSaida.css"/>
    </head>
    <body>
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

        <main>
            <h1><%=placa%></h1>
            <form>
                <input hidden value="<%=valorFinal%>" name="valor_pago">
                <input hidden value="<%=placa%>" name="placa">
                <input hidden value="<%=numero%>" name="numero">
                <input hidden type="datetime-local" name="data_hora_saida" value="<%=dataHoraSaida%>">

                <h1>Pagamento</h1>

                <%
                    if (horasTotais < 1) {
                %>
                <p>Tempo Permanecido <%=minutos%> Minutos</p>
                <%
                } else {
                %>
                <p>Tempo Permanecido <%=horasTotais%> Horas</p>
                <%
                    }
                %>

                <strong>Preço Final: R$<%=valorFinal%></strong>

                <label>Forma de pagamento</label>
                <select name="pagamento">
                    <option value="cartao">Cartão de Credito</option>
                    <option value="dinheiro">Dinheiro</option>
                </select>

                <button type="submit">Pagar</button>

            </form>

        </main>
    </body>
</html>