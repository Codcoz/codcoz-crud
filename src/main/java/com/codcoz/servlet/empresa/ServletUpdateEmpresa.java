package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateEmpresa", value = "/ServletUpdateEmpresa")
public class ServletUpdateEmpresa extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Empresa com os dados recebidos do formulário
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                request.getParameter("cnpj"),
                request.getParameter("email")
        );

        // Executa o update via DAO e recebe o status da operação
        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);

        // Define a mensagem com base no status da atualização
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + empresa.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + empresa.getNome() + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com";
                break;
            default:
                mensagem = "A atualização de " + empresa.getNome() + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de empresas para exibir na JSP
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}