package com.codcoz.dao;

import com.codcoz.model.Empresa;

public class Main {
    public static void main(String[] args) {
        System.out.println(new Conexao().conectar());
        EmpresaDAO empresaDAO = new EmpresaDAO();
        for (Empresa empresa : empresaDAO.read()){
            System.out.printf("id: %d; idEndereco: %d; nome: %s; cnpj: %s;\n",empresa.getId(),empresa.getIdEndereco(),empresa.getNome(),empresa.getCnpj());
        }
    }
}
