<?php 
require_once("../../../conexao.php");
$tabela = 'dias';

$id = $_POST['id'];
$dias = $_POST['dias'];

// Verificar se o dia já está cadastrado para o funcionário
$query = $pdo->prepare("SELECT * FROM $tabela WHERE funcionario = :id AND dia = :dias");
$query->bindParam(':id', $id);
$query->bindParam(':dias', $dias);
$query->execute();

if ($query->rowCount() > 0) {
    echo 'Dia já cadastrado!';
    exit();
}

// Inserir novo dia
$query = $pdo->prepare("INSERT INTO $tabela (dia, funcionario) VALUES (:dias, :id)");
$query->bindParam(':dias', $dias);
$query->bindParam(':id', $id);
$query->execute();

echo 'Salvo com Sucesso';
?>