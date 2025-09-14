package com.codcoz.model;

public class Endereco {
    private Integer id;
    private String rua;
    private String complemento;
    private String cidade;
    private String estado;
    private String cep;
    private String numero;

    public Endereco(Integer id, String rua, String complemento, String cidade, String estado, String cep, String numero) {
        this.id = id;
        this.rua = rua;
        this.complemento = complemento;
        this.cidade = cidade;
        this.estado = estado;
        this.cep = cep;
        this.numero = numero;
    }

    public Integer getId() {
        return id;
    }

    public String getRua() {
        return rua;
    }

    public String getComplemento() {
        return complemento;
    }

    public String getCidade() {
        return cidade;
    }

    public String getEstado() {
        return estado;
    }

    public String getCep() {
        return cep;
    }

    public String getNumero() {
        return numero;
    }
}

