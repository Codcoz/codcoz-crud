package com.codcoz.model;

public class Funcionario {
    private Integer id;
    private Integer idEmpresa;
    private String funcao;
    private String nome;
    private String sobrenome;
    private String cpf;

    public Funcionario(Integer id, Integer idEmpresa, String funcao, String nome, String sobrenome, String cpf) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.funcao = funcao;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.cpf = cpf;
    }

    public Funcionario(Integer idEmpresa, String funcao, String nome, String sobrenome, String cpf) {
        this.idEmpresa = idEmpresa;
        this.funcao = funcao;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.cpf = cpf;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public String getFuncao() {
        return funcao;
    }

    public String getNome() {
        return nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public String getCpf() {
        return cpf;
    }


}