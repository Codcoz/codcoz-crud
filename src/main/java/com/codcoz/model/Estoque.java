package com.codcoz.model;

public class Estoque {
    private Integer id;
    private Integer idEmpresa;
    private String tipoEstoque;
    private Integer capacidade;

    public Estoque(Integer id, Integer idEmpresa, String tipoEstoque, Integer capacidade) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.tipoEstoque = tipoEstoque;
        this.capacidade = capacidade;
    }

    public Estoque(Integer idEmpresa, String tipoEstoque, Integer capacidade) {
        this.idEmpresa = idEmpresa;
        this.tipoEstoque = tipoEstoque;
        this.capacidade = capacidade;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public String getTipoEstoque() {
        return tipoEstoque;
    }

    public Integer getCapacidade() {
        return capacidade;
    }
}