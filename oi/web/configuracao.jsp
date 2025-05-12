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
        <link rel="stylesheet" href="stylesConfig.css"/>
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
        <main style="display: flex; justify-content: center; height: 50vh; align-items: center; padding: 80px">
            <form action="configurar.jsp" method="post" style="display: flex; width: 20%; min-width: 450px; flex-direction: column; align-items: center; justify-items: center; gap: 40px; border: 1px solid black; padding: 40px 20px;">
                <h1>Configurações</h1> 
                <p style="display: flex; flex-direction: column; width: 100%; gap: 20px;">
                    <label>Valor Primeira Hora</label>
                    <input style="height: 40px; padding-left: 10px; border-radius: 5px; outline:none;"  placeholder="Valor Primeira Hora" required name="valor_primeira_hora">
                </p>
                <p style="display: flex; flex-direction: column; width: 100%; gap: 20px;">
                    <label>Valor Horas Adicionais</label>
                    <input style="height: 40px; padding-left: 10px; border-radius: 5px; outline:none;" placeholder="Valor Horas Adicionais" required name="valor_hora_adicional">
                </p>
                <input value="31" hidden name="vagas_totais">
                    
                <input style="height: 40px; width: 80%; border-radius: 6px;" value="Enviar" type="submit">
                
            </form>
        </main>
    </body>
</html>