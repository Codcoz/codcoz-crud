package com.codcoz.dao;  // Pacote onde a classe está localizada

import com.codcoz.conexao.Conexao; // Importa a classe responsável pela conexão com o banco de dados
import com.codcoz.model.NotaFiscalXml; // Importa o modelo da nota fiscal XML

import java.sql.*; // Importa as classes para manipulação de SQL (Connection, PreparedStatement, etc.)
import java.util.ArrayList;
import java.util.List;

// Classe responsável por fazer operações no banco de dados relacionadas à tabela "nota_fiscal_xml"
public class NotaFiscalXmlDAO {

    // Método para inserir uma nova nota fiscal XML no banco
    public boolean create(NotaFiscalXml notaFiscalXml) {
        // Comando SQL de inserção
        String sql = "INSERT INTO nota_fiscal_xml (id_empresa, data_emissao, xml_string, numero_nota) VALUES (?, ?, ?, ?)";
        Conexao conexao = new Conexao(); // Cria uma nova instância da conexão
        Connection conn = conexao.conectar(); // Conecta ao banco de dados

        try {
            // Prepara a instrução SQL
            PreparedStatement pstmt = conn.prepareStatement(sql);
            // Define os valores para os parâmetros da query
            pstmt.setInt(1, notaFiscalXml.getIdEmpresa());
            pstmt.setDate(2, notaFiscalXml.getDataEmissao());
            pstmt.setString(3, notaFiscalXml.getXmlString());
            pstmt.setString(4, notaFiscalXml.getNumeroNota());

            // Executa a inserção e verifica se alguma linha foi afetada
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Nota Fiscal XML criada com sucesso!");
                return true; // Sucesso
            }
            return false; // Nenhuma linha inserida
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // Exibe o erro no console
            return false; // Retorna falso em caso de erro
        } finally {
            conexao.desconectar(conn); // Fecha a conexão com o banco
        }
    }

    // Método que retorna todas as notas fiscais XML cadastradas no banco
    public List<NotaFiscalXml> read() {
        ArrayList<NotaFiscalXml> listNotaFiscalXml = new ArrayList<>(); // Lista que armazenará os resultados
        Conexao conexao = new Conexao(); // Cria uma conexão
        Connection conn = conexao.conectar(); // Conecta ao banco
        ResultSet rs; // Armazena o resultado da consulta

        try {
            // Cria o objeto Statement para executar o SQL
            Statement stmt = conn.createStatement();
            // Executa a consulta
            rs = stmt.executeQuery("SELECT * FROM nota_fiscal_xml");

            // Percorre os resultados da consulta
            while (rs.next()) {
                // Cria um objeto NotaFiscalXml com os dados do banco
                NotaFiscalXml notaFiscalXml = new NotaFiscalXml(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getDate("data_emissao"),
                        rs.getString("xml_string"),
                        rs.getString("numero_nota")
                );
                // Adiciona à lista
                listNotaFiscalXml.add(notaFiscalXml);
            }
            System.out.println("read de nota fiscal XML com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // Mostra erro caso ocorra
        } finally {
            conexao.desconectar(conn); // Fecha a conexão
        }
        return listNotaFiscalXml; // Retorna a lista com todas as notas
    }
    public List<NotaFiscalXml> buscarPorEmpresa(int idEmpresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<NotaFiscalXml> listnotaFiscalXml = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT * FROM nota_fiscal_xml WHERE id_empresa = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,idEmpresa);
            rs= pstmt.executeQuery();
            while (rs.next()) {
                NotaFiscalXml notaFiscalXml = new NotaFiscalXml(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getDate("data_emissao"),
                        rs.getString("xml_string"),
                        rs.getString("numero_nota")
                );
                listnotaFiscalXml.add(notaFiscalXml);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return listnotaFiscalXml;
    }
    public NotaFiscalXml buscarPorId(int id) {
        NotaFiscalXml nota = null; // Inicializa o objeto como nulo
        try (Connection conn = new Conexao().conectar(); // Conecta ao banco (try-with-resources fecha automaticamente)
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM nota_fiscal_xml WHERE id = ?")) {

            stmt.setInt(1, id); // Define o valor do parâmetro ID
            ResultSet rs = stmt.executeQuery(); // Executa a consulta

            // Se encontrar um registro, cria o objeto NotaFiscalXml
            if (rs.next()) {
                nota = new NotaFiscalXml(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getDate("data_emissao"),
                        rs.getString("xml_string"),
                        rs.getString("numero_nota")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Exibe o erro no console
        }
        return nota; // Retorna o objeto encontrado ou null se não existir
    }

    // Método para atualizar os dados de uma nota fiscal XML existente
    public int update(NotaFiscalXml notaFiscalXML) {
        // Comando SQL de atualização
        String sql = "UPDATE nota_fiscal_xml SET id_empresa = ?, data_emissao = ?, xml_string = ?, numero_nota = ? WHERE id = ?";
        Conexao conexao = new Conexao(); // Cria uma instância de conexão
        Connection conn = conexao.conectar(); // Conecta ao banco

        try {
            // Prepara o SQL para execução
            PreparedStatement pstmt = conn.prepareStatement(sql);
            // Define os novos valores dos campos
            pstmt.setInt(1, notaFiscalXML.getIdEmpresa());
            pstmt.setDate(2, notaFiscalXML.getDataEmissao());
            pstmt.setString(3, notaFiscalXML.getXmlString());
            pstmt.setString(4, notaFiscalXML.getNumeroNota());
            pstmt.setInt(5, notaFiscalXML.getId());

            // Executa o update e verifica se foi bem-sucedido
            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de nota fiscal XML com sucesso");
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // Mostra erro no console
            return 0; // erro interno
        } finally {
            conexao.desconectar(conn); // Fecha conexão
        }
        return -1; // erro desconhecido
    }

    // Método para excluir uma nota fiscal XML pelo ID
    public int delete(int id) {
        Conexao conexao = new Conexao(); // Cria uma conexão
        Connection conn = conexao.conectar(); // Conecta ao banco

        try {
            // Prepara o comando SQL de exclusão
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM nota_fiscal_xml WHERE id = ?");
            pstmt.setInt(1, id); // Define o parâmetro ID

            // Executa e verifica se alguma linha foi deletada
            if (pstmt.executeUpdate() > 0) {
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace(); // Mostra erro
            return 0; // erro interno
        } finally {
            conexao.desconectar(conn); // Fecha a conexão
        }
        return -1; // erro desconhecido
    }
}
