package com.codcoz.model;

import java.sql.Date;

public class Alerta {
    private Integer id;
    private Integer idEmpresa;
    private Integer idProduto;
    private Date dataCriacao;
    private String status;
    private String tipoAlerta;

    public Alerta(Integer id, Integer idEmpresa, Integer idProduto, Date dataCriacao, String status, String tipoAlerta) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.idProduto = idProduto;
        this.dataCriacao = dataCriacao;
        this.status = status;
        this.tipoAlerta = tipoAlerta;
    }

    public Alerta(Integer idEmpresa, Integer idProduto, Date dataCriacao, String status, String tipoAlerta) {
        this.idEmpresa = idEmpresa;
        this.idProduto = idProduto;
        this.dataCriacao = dataCriacao;
        this.status = status;
        this.tipoAlerta = tipoAlerta;
    }

    public Integer getId() {
        return id;
    }

    public Integer getIdEmpresa() {
        return idEmpresa;
    }

    public Integer getIdProduto() {
        return idProduto;
    }

    public Date getDataCriacao() {
        return dataCriacao;
    }

    public String getStatus() {
        return status;
    }

    public String getTipoAlerta() {
        return tipoAlerta;
    }
}