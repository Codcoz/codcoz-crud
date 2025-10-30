package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import com.codcoz.model.Empresa;

@WebServlet(name = "ServletDeleteEmpresa", value = "/ServletDeleteEmpresa")
public class ServletDeleteEmpresa extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém o ID da empresa a ser excluída
        int id = Integer.parseInt(request.getParameter("id"));

        EmpresaDAO dao = new EmpresaDAO();
        // Busca o nome da empresa para montar a mensagem
        String empresa = dao.buscarPorId(id).getNome();

        // Executa a exclusão via DAO e recebe o status da operação
        int status = dao.delete(id);

        // Define a mensagem com base no status da exclusão
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão de " + empresa + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão falhou: a empresa " + empresa + " está associada a outra tabela. Apague os campos relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão de " + empresa + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão de " + empresa + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de empresas para exibir na JSP
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/empresaJSP/readEmpresa.jsp");        dispatcher.forward(request, response);
    }
}