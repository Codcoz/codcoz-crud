package com.codcoz.dao;
import java.sql.*;
import com.codcoz.model.Alerta;

public class AlertaDAO {

    public void create(Alerta alerta) {
        String sql = "INSERT INTO alerta (id_empresa, id_produto, data_criacao, status, tipo_alerta) VALUES (?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, alerta.getIdEmpresa());
            pstmt.setInt(2, alerta.getIdProduto());
            pstmt.setString(3, alerta.getDataCriacao());
            pstmt.setString(4, alerta.getStatus());
            pstmt.setString(5, alerta.getTipoAlerta());

            pstmt.executeUpdate();
            System.out.println("Alerta inserido com sucesso!");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            conexao.desconectar(conn);
        }
    }
    public ResultSet read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rset = null;
        try {
            Statement stmt = conn.createStatement();
            rset = stmt.executeQuery("SELECT * FROM Alerta");

            conexao.desconectar(conn);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rset;
    }
    public void update(Alerta alerta){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql ="UPDATE Produto SET id_empresa = ?, id_produto = ?,  data_criacao= ?, status = ?, tipo_alerta = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,alerta.getIdEmpresa());
            pstmt.setInt(2,alerta.getIdProduto());
            pstmt.setString(3, alerta.getDataCriacao());
            pstmt.setString(4,alerta.getStatus());
            pstmt.setString(5, alerta.getTipoAlerta());
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public void delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "DELETE FROM alerta WHERE id = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,id);
            pstmt.execute();
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }

}