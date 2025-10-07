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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lê parâmetros
        String idStr         = request.getParameter("id");
        String idEnderecoStr = request.getParameter("idEndereco");
        String nome          = request.getParameter("nome");
        String cnpj          = request.getParameter("cnpj");
        String email         = request.getParameter("email");

        boolean temErro = false;
        Integer id = null;
        Integer idEndereco = null;

        // Validação do ID
        try {
            id = Integer.valueOf(idStr);
            if (id <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroId", "ID da empresa inválido.");
            temErro = true;
        }

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
            request.setAttribute("idValue", idStr);
            request.setAttribute("idEnderecoValue", idEnderecoStr);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("cnpjValue", cnpj);
            request.setAttribute("emailValue", email);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/updateEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza o CNPJ
        String cnpjNormalizado = cnpj.replaceAll("\\D", "");

        // Cria o objeto Empresa
        Empresa empresa = new Empresa(
                id,
                idEndereco,
                nome,
                cnpjNormalizado,
                email
        );

        // Executa o update via DAO
        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);

        // Define a mensagem com base no status
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + empresa.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + empresa.getNome() + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização de " + empresa.getNome() + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de empresas
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
