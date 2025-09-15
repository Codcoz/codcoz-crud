package com.codcoz.model;

public class Funcionario {
    private Integer id;
    private Integer idEmpresa;
    private Integer idFuncao;
    private String nome;
    private String sobrenome;
    private String dataAdmissao;
    private String cpf;
    private Double salario;

    public Funcionario(Integer id, Integer idEmpresa, Integer idFuncao, String nome, String sobrenome, String dataAdmissao, String cpf, Double salario) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.idFuncao = idFuncao;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataAdmissao = dataAdmissao;
        this.cpf = cpf;
        this.salario = salario;
    }

    public Funcionario(Integer idEmpresa, Integer idFuncao, String nome, String sobrenome, String dataAdmissao, String cpf, Double salario) {
        this.idEmpresa = idEmpresa;
        this.idFuncao = idFuncao;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataAdmissao = dataAdmissao;
        this.cpf = cpf;
        this.salario = salario;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public Integer getIdFuncao() {
        return idFuncao;
    }

    public String getNome() {
        return nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public String getDataAdmissao() {
        return dataAdmissao;
    }

    public String getCpf() {
        return cpf;
    }

    public Double getSalario() {
        return salario;
    }
}