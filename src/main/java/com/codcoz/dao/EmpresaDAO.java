package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Empresa;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpresaDAO {

    public boolean create(Empresa empresa) {
        String sql = "INSERT INTO empresa (id_endereco, nome, cnpj) VALUES (?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empresa.getIdEndereco());
            pstmt.setString(2, empresa.getNome());
            pstmt.setString(3, empresa.getCnpj());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("Empresa criada com sucesso!");
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        } finally {
            conexao.desconectar(conn);
        }
    }

    public List<Empresa> read() {
        ArrayList<Empresa> empresaList = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM empresa");
            while (rs.next()) {
                Empresa empresa = new Empresa(
                        rs.getInt("id"),
                        rs.getInt("id_endereco"),
                        rs.getString("nome"),
                        rs.getString("cnpj")
                );
                empresaList.add(empresa);
            }
            System.out.println("read de empresa com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return empresaList;
    }

    public int update(Empresa empresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE empresa SET id_endereco = ?, nome = ?, cnpj = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empresa.getIdEndereco());
            pstmt.setString(2, empresa.getNome());
            pstmt.setString(3, empresa.getCnpj());
            pstmt.setInt(4, empresa.getId());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de empresa com sucesso");
                return 1;
            }
            return 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return -1;
        } finally {
            conexao.desconectar(conn);
        }
    }

    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM empresa WHERE id = ?");
            pstmt.setInt(1, id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("delete de empresa com sucesso");
                return 1;
            }
            return 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return -1;
        } finally {
            conexao.desconectar(conn);
        }
    }
}
