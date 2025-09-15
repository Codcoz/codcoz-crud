package com.codcoz.model;

public class Alerta {
    private Integer id;
    private Integer idEmpresa;
    private Integer idProduto;
    private String dataCriacao;
    private String status;
    private String tipoAlerta;

    public Alerta(Integer id, Integer idEmpresa, Integer idProduto, String dataCriacao, String status, String tipoAlerta) {
        this.id = id;
        this.idEmpresa = idEmpresa;
        this.idProduto = idProduto;
        this.dataCriacao = dataCriacao;
        this.status = status;
        this.tipoAlerta = tipoAlerta;
    }

    public Alerta(Integer idEmpresa, Integer idProduto, String dataCriacao, String status, String tipoAlerta) {
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

    public String getDataCriacao() {
        return dataCriacao;
    }

    public String getStatus() {
        return status;
    }

    public String getTipoAlerta() {
        return tipoAlerta;
    }
}


