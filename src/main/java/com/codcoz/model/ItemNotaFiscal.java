package com.codcoz.model;

public class ItemNotaFiscal {
    private Integer id;
    private Integer idNotaFiscalXml;
    private Integer idEmpresa;
    private Double quantidade;
    private Double preco;

    public ItemNotaFiscal(Integer id, Integer idNotaFiscalXml, Integer idEmpresa, Double quantidade, Double precoUnitario) {
        this.id = id;
        this.idNotaFiscalXml = idNotaFiscalXml;
        this.idEmpresa = idEmpresa;
        this.quantidade = quantidade;
        this.preco = preco;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdNotaFiscalXml() {
        return idNotaFiscalXml;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public Double getQuantidade() {
        return quantidade;
    }

    public Double getPreco() {
        return preco;
    }
}