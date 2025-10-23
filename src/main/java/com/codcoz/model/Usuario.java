package com.codcoz.model;

public class Usuario {
    private Integer id;
    private String nome;
    private String email;
    private String senha;
    private String genero;

    public Usuario(Integer id, String nome, String email, String senha, String genero) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.genero = genero;
    }

    public Integer getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getSenha() {
        return senha;
    }

    public String getGenero() {
        return genero;
    }
}
