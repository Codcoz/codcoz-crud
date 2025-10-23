// Define o pacote da servlet responsável por criar uma nova empresa
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
@WebServlet(name = "ServletCreateEmpresa", value = "/ServletCreateEmpresa")
public class ServletCreateEmpresa extends HttpServlet {

    // Método que trata requisições POST para criar uma empresa
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Remove caracteres não numéricos do CNPJ
        String cnpjOriginal = request.getParameter("cnpj");
        String cnpj = cnpjOriginal.replaceAll("\\D", "");

        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                cnpj,
                request.getParameter("email")
        );

        // Executa a criação via DAO
        EmpresaDAO dao = new EmpresaDAO();
        String mensagem;
        int status= dao.create(empresa);

        // Define a mensagem com base no resultado da operação
        switch (status){
            case 1:
                mensagem = "A criação de " + empresa.getNome() + " foi realizada com sucesso";
                break;
            case 0:
                mensagem = "A criaçao de " + empresa.getNome() + " falhou, esse cnpj ja foi vinculado";
                break;
            case -1:
                mensagem = "A criaçao de " + empresa.getNome() + " falhou, esse email ja foi vinculado";
                break;
            case -2:
               mensagem = "A criação falhou: erro desconhecido. Entre em contato em contato.codcoz@gmail.com";
               break;
            default:
                mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        // Adiciona a mensagem e a lista atualizada de empresas à requisição
        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        // Encaminha para a página JSP que exibe as empresas
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
