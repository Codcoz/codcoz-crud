package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateFuncionario", value = "/ServletCreateFuncionario")
public class ServletCreateFuncionario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lê parâmetros
        String idEmpresaStr = request.getParameter("idEmpresa");
        String funcao       = request.getParameter("funcao");
        String nome         = request.getParameter("nome");
        String sobrenome    = request.getParameter("sobrenome");
        String cpf          = request.getParameter("cpf");

        // Flags de erro
        boolean temErro = false;

        // Validação idEmpresa (numérico e positivo)
        Integer idEmpresa = null;
        try {
            idEmpresa = Integer.valueOf(idEmpresaStr);
            if (idEmpresa <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroIdEmpresa", "ID da empresa inválido.");
            temErro = true;
        }

        // Validação de campos obrigatórios (nome/sobrenome/função)
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

        // Validação de CPF: aceita com máscara (000.000.000-00) ou só dígitos (11 dígitos)
        if (cpf == null || !cpf.matches("^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$|^\\d{11}$")) {
            request.setAttribute("erroCpf", "CPF inválido. Use o formato 000.000.000-00 ou apenas números.");
            temErro = true;
        }

        // Se houve erro, devolve para o formulário preservando o que o usuário digitou
        if (temErro) {
            request.setAttribute("idEmpresaValue", idEmpresaStr);
            request.setAttribute("funcaoValue", funcao);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("sobrenomeValue", sobrenome);
            request.setAttribute("cpfValue", cpf);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/createFuncionario.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza CPF para apenas dígitos (opcional)
        String cpfNormalizado = cpf.replaceAll("\\D", "");

        // Cria objeto e persiste
        Funcionario funcionario = new Funcionario(
                idEmpresa,
                funcao,
                nome,
                sobrenome,
                cpfNormalizado
        );

        FuncionarioDAO dao = new FuncionarioDAO();
        String mensagem = dao.create(funcionario)
                ? "A criação de " + nome + " " + sobrenome + " foi realizada com sucesso."
                : "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";

        // Prepara retorno para a listagem
        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
