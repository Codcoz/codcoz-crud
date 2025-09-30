package com.codcoz.model;

import java.sql.Date;

public class NotaFiscalXml {
    private Integer id;
    private Integer idEmpresa;
    private Date dataEmissao;
    private String xmlString;
    private String numeroNota;

    public NotaFiscalXml(Integer id, Integer idEmpresa, Date dataEmissao, String xmlString, String numeroNota) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.dataEmissao = dataEmissao;
        this.xmlString = xmlString;
        this.numeroNota = numeroNota;
    }

    public NotaFiscalXml(Integer idEmpresa, Date dataEmissao, String xmlString, String numeroNota) {
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

    public Date getDataEmissao() {
        return dataEmissao;
    }

    public String getXmlString() {
        return xmlString;
    }

    public String getNumeroNota() {
        return numeroNota;
    }
}