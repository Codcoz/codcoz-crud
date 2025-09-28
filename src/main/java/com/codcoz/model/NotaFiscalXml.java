package com.codcoz.model;

public class NotaFiscalXml {
    private Integer id;
    private Integer idEmpresa;
    private String dataEmissao;
    private String xmlString;
    private String numeroNota;

    public NotaFiscalXml(Integer id, Integer idEmpresa, String dataEmissao, String xmlString, String numeroNota) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.dataEmissao = dataEmissao;
        this.xmlString = xmlString;
        this.numeroNota = numeroNota;
    }

    public NotaFiscalXml(Integer idEmpresa, String dataEmissao, String xmlString, String numeroNota) {
        this.idEmpresa = idEmpresa;
        this.dataEmissao = dataEmissao;
        this.xmlString = xmlString;
        this.numeroNota = numeroNota;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public String getDataEmissao() {
        return dataEmissao;
    }

    public String getXmlString() {
        return xmlString;
    }

    public String getNumeroNota() {
        return numeroNota;
    }
}