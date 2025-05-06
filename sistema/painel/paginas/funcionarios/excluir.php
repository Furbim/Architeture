<?php 
require_once("../../../conexao.php");
$tabela = 'usuarios';

$id = $_POST['id'];

// Pegando dados do usuário
$query = $pdo->query("SELECT * FROM $tabela WHERE id = '$id'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);

if ($total_reg == 0) {
    echo 'Usuário não encontrado';
    exit();
}

$foto = $res[0]['foto'];
$barbearia_id = $res[0]['barbearia_id'];

// Caminho da imagem (organizado por barbearia)
$caminho_img = '../../img/perfil/' . $barbearia_id . '/' . $foto;

// Excluir foto se não for a padrão
if ($foto != "sem-foto.jpg" && file_exists($caminho_img)) {
    @unlink($caminho_img);
}

// Excluir usuário
$pdo->query("DELETE FROM $tabela WHERE id = '$id'");

echo 'Excluído com Sucesso';
?>