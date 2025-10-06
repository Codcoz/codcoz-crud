package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Endereco;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnderecoDAO {

    // Insere um novo endereço no banco
    public boolean create(Endereco endereco) {
        String sql = "INSERT INTO endereco (rua, complemento, cidade, estado, cep, numero) VALUES (?, ?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, endereco.getRua());
            pstmt.setString(2, endereco.getComplemento());
            pstmt.setString(3, endereco.getCidade());
            pstmt.setString(4, endereco.getEstado());
            pstmt.setString(5, endereco.getCep());
            pstmt.setString(6, endereco.getNumero());

            // Retorna true se ao menos uma linha foi inserida
            if (pstmt.executeUpdate() > 0) {
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        } finally {
            conexao.desconectar(conn); // garante fechamento da conexão
        }
    }

    // Retorna todos os endereços cadastrados
    public List<Endereco> read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Endereco> listaEnderecos = new ArrayList<>();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM endereco order by id");

            // Mapeia cada linha do resultado para um objeto Endereco
            while (rs.next()) {
                Endereco endereco = new Endereco(
                        rs.getInt("id"),
                        rs.getString("rua"),
                        rs.getString("complemento"),
                        rs.getString("cidade"),
                        rs.getString("estado"),
                        rs.getString("cep"),
                        rs.getString("numero")
                );
                listaEnderecos.add(endereco);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return listaEnderecos;
    }

    // Busca um endereço específico pelo ID
    public Endereco buscarPorId(int id) {
        Endereco endereco = null;
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM endereco WHERE id = ?")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            // Retorna o primeiro resultado encontrado
            if (rs.next()) {
                endereco = new Endereco(
                        rs.getInt("id"),
                        rs.getString("rua"),
                        rs.getString("complemento"),
                        rs.getString("cidade"),
                        rs.getString("estado"),
                        rs.getString("cep"),
                        rs.getString("numero")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return endereco;
    }

    // Atualiza os dados de um endereço existente
    public int update(Endereco endereco) {
        String sql = "UPDATE endereco SET rua = ?, complemento = ?, cidade = ?, estado = ?, cep = ?, numero = ? WHERE id = ?";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, endereco.getRua());
            pstmt.setString(2, endereco.getComplemento());
            pstmt.setString(3, endereco.getCidade());
            pstmt.setString(4, endereco.getEstado());
            pstmt.setString(5, endereco.getCep());
            pstmt.setString(6, endereco.getNumero());
            pstmt.setInt(7, endereco.getId());

            if (pstmt.executeUpdate() > 0) {
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return 0; // erro interno
        } finally {
            conexao.desconectar(conn);
        }
        return -1; // erro desconhecido
    }

    // Exclui um endereço pelo ID
    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM endereco WHERE id = ?");
            pstmt.setInt(1, id);

            if (pstmt.executeUpdate() > 0) {
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            if (sqle.getMessage().contains("still referenced")){
                return 0; // está vinculado a outra tabela
            }
            return -1; // erro interno
        } finally {
            conexao.desconectar(conn);
        }
        return -2; // falha genérica
    }
}