package com.codcoz.model;

public class Empresa {
    private Integer id;
    private Integer idEndereco;
    private String nome;
    private String cnpj;

    public Empresa(Integer id, Integer idEndereco, String nome, String cnpj) {
        this.id = id;
        this.idEndereco = idEndereco;
        this.nome = nome;
        this.cnpj = cnpj;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEndereco() {
        return idEndereco;
    }

    public String getNome() {
        return nome;
    }

    public String getCnpj() {
        return cnpj;
    }
}