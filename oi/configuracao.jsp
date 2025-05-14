<!DOCTYPE html>

<%

    String usuarioLogado = (String) session.getAttribute("usuario");
        
        if(usuarioLogado == null){
            response.sendRedirect("index.html");
            return;
        }

%>




<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styleConfig.css"/>
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
            <form action="configurar.jsp" method="post" >
                <h1>Configurações</h1> 
                <p>
                    <label>Valor Primeira Hora</label>
                    <input  placeholder="Valor Primeira Hora" required name="valor_primeira_hora">
                </p>
                <p>
                    <label>Valor Horas Adicionais</label>
                    <input placeholder="Valor Horas Adicionais" required name="valor_hora_adicional">
                </p>
                <input value="31" hidden name="vagas_totais">
                    
                <input style="height: 40px; width: 80%; border-radius: 6px;" value="Enviar" type="submit">
                
            </form>
        </main>
    </body>
</html>