package com.codcoz.model;

public class    Empresa {
    private Integer id;
    private Integer idEndereco;
    private String nome;
    private String cnpj;
    private String email;

    public Empresa(Integer id, Integer idEndereco, String nome, String cnpj, String email) {
        this.id = id;
        this.idEndereco = idEndereco;
        this.nome = nome;
        this.cnpj = cnpj;
        this.email = email;
    }

    public Empresa(Integer idEndereco, String nome, String cnpj, String email) {
        this.idEndereco = idEndereco;
        this.nome = nome;
        this.cnpj = cnpj;
        this.email = email;
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

    public String getEmail() {
        return email;
    }
}