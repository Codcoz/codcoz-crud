package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateEmpresa", value = "/ServletCreateEmpresa")
public class ServletCreateEmpresa extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lê parâmetros
        String idEnderecoStr = request.getParameter("idEndereco");
        String nome           = request.getParameter("nome");
        String cnpj           = request.getParameter("cnpj");
        String email          = request.getParameter("email");

        boolean temErro = false;
        Integer idEndereco = null;

        // Validação do ID do endereço
        try {
            idEndereco = Integer.valueOf(idEnderecoStr);
            if (idEndereco <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroIdEndereco", "ID do endereço inválido.");
            temErro = true;
        }

        // Validação do nome
        if (nome == null || nome.trim().isEmpty()) {
            request.setAttribute("erroNome", "Nome da empresa é obrigatório.");
            temErro = true;
        }

        // Validação do CNPJ
        if (cnpj == null || !cnpj.matches("^\\d{2}\\.\\d{3}\\.\\d{3}/\\d{4}-\\d{2}$|^\\d{14}$")) {
            request.setAttribute("erroCnpj", "CNPJ inválido. Use o formato 00.000.000/0000-00 ou apenas números.");
            temErro = true;
        }

        // Validação do e-mail
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("erroEmail", "E-mail inválido. Use um formato como nome@dominio.com.");
            temErro = true;
        }

        // Se houve erro, devolve para o formulário preservando os dados
        if (temErro) {
            request.setAttribute("idEnderecoValue", idEnderecoStr);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("cnpjValue", cnpj);
            request.setAttribute("emailValue", email);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/createEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza o CNPJ
        String cnpjNormalizado = cnpj.replaceAll("\\D", "");

        // Cria objeto e persiste
        Empresa empresa = new Empresa(
                idEndereco,
                nome,
                cnpjNormalizado,
                email
        );

        EmpresaDAO dao = new EmpresaDAO();
        String mensagem = dao.create(empresa)
                ? "A criação de " + empresa.getNome() + " foi realizada com sucesso."
                : "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com.";

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de empresas
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
