package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateFuncionario", value = "/ServletUpdateFuncionario")
public class ServletUpdateFuncionario extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ==== Leitura dos parâmetros ====
        String idStr        = request.getParameter("id");
        String idEmpresaStr = request.getParameter("idEmpresa");
        String funcao       = request.getParameter("funcao");
        String nome         = request.getParameter("nome");
        String sobrenome    = request.getParameter("sobrenome");
        String cpf          = request.getParameter("cpf");

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

        Integer idEmpresa = null;
        try {
            idEmpresa = Integer.valueOf(idEmpresaStr);
            if (idEmpresa <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroIdEmpresa", "ID da empresa inválido.");
            temErro = true;
        }

        if (nome == null || nome.trim().isEmpty()) {
            request.setAttribute("erroNome", "Nome é obrigatório.");
            temErro = true;
        }
        if (sobrenome == null || sobrenome.trim().isEmpty()) {
            request.setAttribute("erroSobrenome", "Sobrenome é obrigatório.");
            temErro = true;
        }
        if (funcao == null || funcao.trim().isEmpty()) {
            request.setAttribute("erroFuncao", "Função é obrigatória.");
            temErro = true;
        }

        // Aceita 000.000.000-00 ou somente 11 dígitos
        if (cpf == null || !cpf.matches("^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$|^\\d{11}$")) {
            request.setAttribute("erroCpf", "CPF inválido. Use 000.000.000-00 ou apenas números.");
            temErro = true;
        }

        if (temErro) {
            // Preserva valores para o formulário de update
            request.setAttribute("idValue", idStr);
            request.setAttribute("idEmpresaValue", idEmpresaStr);
            request.setAttribute("funcaoValue", funcao);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("sobrenomeValue", sobrenome);
            request.setAttribute("cpfValue", cpf);

            // Volta para o formulário de atualização
            RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/updateFuncionario.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza CPF para apenas dígitos (opcional)
        String cpfNormalizado = cpf.replaceAll("\\D", "");

        // ==== Monta objeto e executa update ====
        Funcionario funcionario = new Funcionario(
                id,
                idEmpresa,
                funcao,
                nome,
                sobrenome,
                cpfNormalizado
        );

        FuncionarioDAO dao = new FuncionarioDAO();
        int status = dao.update(funcionario);

        // ==== Mensagem conforme status ====
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + nome + " " + sobrenome + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + nome + " " + sobrenome + " falhou: erro interno. " +
                        "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização de " + nome + " " + sobrenome + " falhou: erro desconhecido. " +
                        "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);

        // ==== Recarrega listagem ====
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
