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

        // ==== Leitura dos parâmetros ====
        String idStr         = request.getParameter("id");
        String idEnderecoStr = request.getParameter("idEndereco");
        String nome          = request.getParameter("nome");
        String cnpj          = request.getParameter("cnpj");
        String email         = request.getParameter("email");

        boolean temErro = false;

        // ==== Validações básicas ====
        Integer id = null;
        try {
            id = Integer.valueOf(idStr);
            if (id <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroId", "ID inválido.");
            temErro = true;
        }

        Integer idEndereco = null;
        try {
            idEndereco = Integer.valueOf(idEnderecoStr);
            if (idEndereco <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroIdEndereco", "ID do endereço inválido.");
            temErro = true;
        }

        if (nome == null || nome.trim().isEmpty()) {
            request.setAttribute("erroNome", "Nome é obrigatório.");
            temErro = true;
        }

        if (cnpj == null || !cnpj.matches("^\\d{2}\\.\\d{3}\\.\\d{3}/\\d{4}-\\d{2}$|^\\d{14}$")) {
            request.setAttribute("erroCnpj", "CNPJ inválido. Use 00.000.000/0000-00 ou apenas números.");
            temErro = true;
        }

        if (email == null || !email.matches("^[\\w\\.-]+@[\\w\\.-]+\\.\\w{2,}$")) {
            request.setAttribute("erroEmail", "E-mail inválido.");
            temErro = true;
        }

        if (temErro) {
            // Preserva valores para o formulário de update
            request.setAttribute("idValue", idStr);
            request.setAttribute("idEnderecoValue", idEnderecoStr);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("cnpjValue", cnpj);
            request.setAttribute("emailValue", email);

            // Volta para o formulário de atualização
            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/updateEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza CNPJ para apenas dígitos
        String cnpjNormalizado = cnpj.replaceAll("\\D", "");

        // ==== Monta objeto e executa update ====
        Empresa empresa = new Empresa(
                id,
                idEndereco,
                nome,
                cnpjNormalizado,
                email
        );

        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);

        // ==== Mensagem conforme status ====
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + nome + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + nome + " falhou: erro interno. " +
                        "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização de " + nome + " falhou: erro desconhecido. " +
                        "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);

        // ==== Recarrega listagem ====
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}