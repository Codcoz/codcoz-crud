package com.codcoz.model;

public class Produto {
    private Integer id;
    private Integer idEmpresa;
    private String unidadeMedida;
    private Double estoqueMinimo;
    private String nome;
    private String categoria;
    private Integer quantidade;

    public Produto(Integer id, Integer idEmpresa, String unidadeMedida, Double estoqueMinimo, String nome, String categoria, Integer quantidade) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.unidadeMedida = unidadeMedida;
        this.estoqueMinimo = estoqueMinimo;
        this.nome = nome;
        this.categoria = categoria;
        this.quantidade = quantidade;
    }

    public Produto(Integer idEmpresa, String unidadeMedida, Double estoqueMinimo, String nome, String categoria, Integer quantidade) {
        this.idEmpresa = idEmpresa;
        this.unidadeMedida = unidadeMedida;
        this.estoqueMinimo = estoqueMinimo;
        this.nome = nome;
        this.categoria = categoria;
        this.quantidade = quantidade;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public String getUnidadeMedida() {
        return unidadeMedida;
    }

    public Double getEstoqueMinimo() {
        return estoqueMinimo;
    }

    public String getNome() {
        return nome;
    }

    public String getCategoria() {
        return categoria;
    }

    public Integer getQuantidade() {
        return quantidade;
    }
}

