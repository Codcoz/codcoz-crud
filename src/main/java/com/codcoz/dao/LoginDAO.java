package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Usuario;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

public class LoginDAO {
    public Optional<Usuario> userExists(String email) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "SELECT * FROM usuario WHERE email = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Usuario usuario = new Usuario(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("senha"),
                        rs.getString("genero")
                );
                return Optional.of(usuario);
            } else {
                return Optional.empty();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return Optional.empty();
        } finally {
            conexao.desconectar(conn);
        }
    }
    public boolean isPwdCorrect(Usuario usuario, String senhaParaChecar){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "SELECT * FROM usuario WHERE email = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usuario.getEmail());
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            return rs.getString("senha").equals(senhaParaChecar);
        }catch (SQLException sqle){
            sqle.printStackTrace();
            return false;
        }
    }


}
