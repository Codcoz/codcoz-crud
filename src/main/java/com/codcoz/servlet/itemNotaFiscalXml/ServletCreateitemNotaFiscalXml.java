package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

    @WebServlet(name = "ServletCreateItemNotaFiscal", value = "/ServletCreateItemNotaFiscal")
    public class ServletCreateitemNotaFiscalXml extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Poderia listar os itens direto se quiser acessar via GET
            ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
            List<ItemNotaFiscal> lista = dao.read();
            request.setAttribute("listaItensNotaFiscal", lista);

            RequestDispatcher dispatcher = request.getRequestDispatcher("readItemNotaFiscal.jsp");
            dispatcher.forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                // Recupera parâmetros do formulário
                Integer id = Integer.valueOf(request.getParameter("id"));
                Integer idNotaFiscalXml = Integer.valueOf(request.getParameter("idNotaFiscalXml"));
                Integer idEmpresa = Integer.valueOf(request.getParameter("idEmpresa"));
                Double quantidade = Double.valueOf(request.getParameter("quantidade"));
                Double preco = Double.valueOf(request.getParameter("preco"));


                // Cria o objeto
                ItemNotaFiscal itemNotaFiscal = new ItemNotaFiscal(idNotaFiscalXml, idEmpresa, quantidade, preco);

                // Chama o DAO
                ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
                dao.create(itemNotaFiscal);
                List<ItemNotaFiscal> lista = dao.read();

                // Define a lista como atributo da request
                request.setAttribute("listaItensNotaFiscal", lista);

                // Encaminha para a página JSP mantendo os dados
                RequestDispatcher dispatcher = request.getRequestDispatcher("readItemNotaFiscal.jsp");
                dispatcher.forward(request, response);

            } catch (NumberFormatException e) {
                // Caso algum parâmetro numérico seja inválido
                request.setAttribute("erro", "Erro ao converter valores numéricos: " + e.getMessage());
                request.getRequestDispatcher("erro.jsp").forward(request, response);
            }
        }
    }


