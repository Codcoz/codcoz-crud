package com.codcoz.dao;

import com.codcoz.model.ItemNotaFiscal;

import java.sql.*;

public class ItemNotaFiscalDAO {

    public void create(ItemNotaFiscal itemNotaFiscal) {
        String sql = "INSERT INTO item_nota_fiscal (id_nota_fiscal_xml, id_empresa, quantidade, preco) VALUES ( ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemNotaFiscal.getIdNotaFiscalXml());
            pstmt.setDouble(2, itemNotaFiscal.getIdEmpresa());
            pstmt.setDouble(3, itemNotaFiscal.getQuantidade());
            pstmt.setDouble(4,itemNotaFiscal.getPreco());

            pstmt.executeUpdate();
            System.out.println("ItemNotaFiscal inserido com sucesso!");

        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }public ResultSet read(){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs = null;
        try{
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from funcionario");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rs;
    }
    public void update(ItemNotaFiscal itemNotaFiscal){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "update item_nota_fiscal set id_nota_fiscal = ?, id_empresa = ?, quantidade = ?, preco = ? where id = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,itemNotaFiscal.getIdNotaFiscalXml());
            pstmt.setInt(2,itemNotaFiscal.getIdEmpresa());
            pstmt.setDouble(3,itemNotaFiscal.getQuantidade());
            pstmt.setDouble(4,itemNotaFiscal.getPreco());
            pstmt.setInt(5,itemNotaFiscal.getId());
            pstmt.executeUpdate();
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
    }

    public void delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM ItemNotaFiscal WHERE DEPTNO = ?");

            pstmt.setInt(1,id);
            pstmt.execute();
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
}
