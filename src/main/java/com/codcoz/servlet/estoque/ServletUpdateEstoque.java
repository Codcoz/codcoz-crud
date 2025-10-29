package com.codcoz.servlet.estoque;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.model.Estoque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateEstoque", value = "/ServletUpdateEstoque")
public class ServletUpdateEstoque extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Coleta os parâmetros do formulário
        int id = Integer.parseInt(request.getParameter("id"));
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        String tipoEstoque = request.getParameter("tipoEstoque");
        int capacidade = Integer.parseInt(request.getParameter("capacidade"));

        // Cria o objeto Estoque
        Estoque estoque = new Estoque(id, idEmpresa, tipoEstoque, capacidade);

        // Executa a atualização via DAO e define a mensagem de retorno
        EstoqueDAO dao = new EstoqueDAO();
        String mensagem;

        if (dao.update(estoque) > 0) {
            mensagem = "O estoque \"" + estoque.getTipoEstoque() + "\" foi atualizado com sucesso.";
        } else {
            mensagem = "A atualização do estoque \"" + estoque.getTipoEstoque() + "\" falhou: erro interno. "
                    + "Entre em contato em contato.codcoz@gmail.com";
        }
        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de estoques para exibir na JSP
        List<Estoque> lista = dao.read();
        request.setAttribute("listaEstoques", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}
