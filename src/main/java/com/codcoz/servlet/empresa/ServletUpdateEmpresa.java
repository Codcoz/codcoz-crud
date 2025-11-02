// Define o pacote da servlet responsável por atualizar dados de empresa
package com.codcoz.servlet.empresa;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletUpdateEmpresa", value = "/ServletUpdateEmpresa")
public class ServletUpdateEmpresa extends HttpServlet {

    // Método que trata requisições POST para atualizar uma empresa
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normaliza o CNPJ removendo caracteres não numéricos
        String cnpjOriginal = request.getParameter("cnpj");
        String cnpj = cnpjOriginal.replaceAll("\\D", "");


        // Cria o objeto Empresa com os dados recebidos do formulário
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                cnpj,
                request.getParameter("email")
        );

        // Executa a atualização via DAO
        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);

        // Define a mensagem com base no resultado da operação
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualizaçao de " + empresa.getNome() + " foi realizada com sucesso";
                break;
            case 0:
                mensagem = "A atualizaçao de " + empresa.getNome() + " falhou, esse cnpj ja foi vinculado";
                break;
            case -1:
                mensagem = "A atualizaçao de " + empresa.getNome() + " falhou, esse email ja foi vinculado";
                break;
            case -2:
                mensagem = "A atualizaçao falhou: erro desconhecido. Entre em contato em contato.codcoz@gmail.com";
                break;
            default:
                mensagem = "A atualizaçao falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        // Adiciona a mensagem e a lista atualizada de empresas à requisição
        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        // Encaminha para a página JSP que exibe as empresas
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
