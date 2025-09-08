package com.codcoz.dao;
import com.codcoz.model.NotaFiscalXml;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class NotaFiscalXmlDAO {

    public void create(NotaFiscalXml notaFiscalXml) {
        String sql = "INSERT INTO nota_fiscal_xml (id_empresa, data_emissao, xml_string, numero_nota) VALUES ( ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, notaFiscalXml.getIdEmpresa());
            pstmt.setString(2, notaFiscalXml.getDataEmissao());
            pstmt.setString(3, notaFiscalXml.getXmlString());
            pstmt.setString(4, notaFiscalXml.getNumeroNota());
            pstmt.executeUpdate();
            System.out.println("create de nota fiscal xml com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public ResultSet read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rset = null;
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM nota_fiscal_xml");
            rset = stmt.executeQuery("SELECT * FROM nota_fiscal_xml");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rset;

    }
    public void update(NotaFiscalXml notaFiscalXML) {
        String sql = "UPDATE nota_fiscal_xml " +
                "SET id_empresa = ?, data_emissao = ?, xml_string = ?, numero_nota = ?" +
                "WHERE id = ?";

        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notaFiscalXML.getIdEmpresa());
            pstmt.setString(2, notaFiscalXML.getDataEmissao());
            pstmt.setString(3, notaFiscalXML.getXmlString());
            pstmt.setString(4, notaFiscalXML.getNumeroNota());
            pstmt.setInt(5, notaFiscalXML.getId());
            pstmt.executeUpdate();
            System.out.println("update nota fiscal xml com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } conexao.desconectar(conn);
    }

    public void delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM Nota_Fiscal_XML WHERE id = ?");

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            System.out.println("delete de nota fiscal xml com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);


    }
}


