<?php 
require_once("../../../conexao.php");
$tabela = 'horarios';

$id = $_POST['id'];
$horario = $_POST['horario'];

// Verificar se o horário já está cadastrado para o funcionário
$query = $pdo->prepare("SELECT * FROM $tabela WHERE funcionario = :id AND horario = :horario");
$query->bindParam(':id', $id);
$query->bindParam(':horario', $horario);
$query->execute();

if ($query->rowCount() > 0) {
    echo 'Horário já cadastrado!';
    exit();
}

// Inserir novo horário
$query = $pdo->prepare("INSERT INTO $tabela (horario, funcionario) VALUES (:horario, :id)");
$query->bindParam(':horario', $horario);
$query->bindParam(':id', $id);
$query->execute();

echo 'Salvo com Sucesso';
?>