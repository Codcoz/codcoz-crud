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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Empresa com os dados recebidos do formulário

        String cnpj = request.getParameter("cnpj");
        String email = request.getParameter("email");

        // Validação de CNPJ
        if (cnpj == null || !cnpj.matches("^\\d{2}\\.\\d{3}\\.\\d{3}/\\d{4}-\\d{2}$|^\\d{14}$")) {
            request.setAttribute("erroEmail", "CNPJ inválido. Use 00.000.000/0000-00 ou apenas números.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/createEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }
        // Validação de E-mail
        if (email == null || !email.matches("^[\\w.%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}(?:\\.br)?$")) {
            request.setAttribute("erroEmail", "E-mail inválido. Use um formato como nome@dominio.com");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/createEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                cnpj,
                email
        );

        // Executa a criação via DAO e define a mensagem com base no resultado
        EmpresaDAO dao = new EmpresaDAO();
        String mensagem;
        if (dao.create(empresa)) {
            mensagem = "A criação de " + empresa.getNome() + " foi realizada com sucesso";
        } else {
            mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
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