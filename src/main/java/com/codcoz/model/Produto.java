package com.codcoz.model;

public class Produto {
    private Integer id;
    private Integer idEmpresa;
    private Integer idItemNotaFiscal;
    private Integer idUnidadeMedida;
    private String nome;
    private Double estoqueMinimo;
    private String categoria;
    private String status;

    public Produto(Integer id, Integer idEmpresa, Integer idItemNotaFiscal, Integer idUnidadeMedida, String nome, Double estoqueMinimo, String categoria, String status) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.idItemNotaFiscal = idItemNotaFiscal;
        this.idUnidadeMedida = idUnidadeMedida;
        this.nome = nome;
        this.estoqueMinimo = estoqueMinimo;
        this.categoria = categoria;
        this.status = status;
    }

    public Produto(Integer idEmpresa, Integer idItemNotaFiscal, Integer idUnidadeMedida, String nome, Double estoqueMinimo, String categoria, String status) {
        this.idEmpresa = idEmpresa;
        this.idItemNotaFiscal = idItemNotaFiscal;
        this.idUnidadeMedida = idUnidadeMedida;
        this.nome = nome;
        this.estoqueMinimo = estoqueMinimo;
        this.categoria = categoria;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public Integer getIdItemNotaFiscal() {
        return idItemNotaFiscal;
    }

    public Integer getIdUnidadeMedida() {
        return idUnidadeMedida;
    }

    public String getNome() {
        return nome;
    }

    public Double getEstoqueMinimo() {
        return estoqueMinimo;
    }

    public String getCategoria() {
        return categoria;
    }

    public String getStatus() {
        return status;
    }
}