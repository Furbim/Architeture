<?php 
require_once("../sistema/conexao.php");

session_start(); // Certifique-se de iniciar a sessão antes de qualquer saída

$tabela = 'clientes';

// Verificar se os dados foram enviados corretamente
if (!isset($_POST['nome']) || !isset($_POST['telefone'])) {
    echo 'Erro: Nome ou telefone não foram enviados!';
    exit();
}

$nome = $_POST['nome'];
$telefone = $_POST['telefone'];

// Validar telefone
$query = $pdo->prepare("SELECT * FROM $tabela WHERE telefone = :telefone");
$query->bindValue(":telefone", $telefone);
$query->execute();
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0) {
    echo 'Telefone já cadastrado, você já está cadastrado!';
    exit();
}

// Inserir novo cliente
$query = $pdo->prepare("INSERT INTO $tabela (nome, telefone, data_cad) VALUES (:nome, :telefone, CURDATE())");
$query->bindValue(":nome", $nome);
$query->bindValue(":telefone", $telefone);
$query->execute();

// Buscar o novo cliente cadastrado
$query = $pdo->prepare("SELECT * FROM $tabela WHERE telefone = :telefone");
$query->bindValue(":telefone", $telefone);
$query->execute();
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0) {
    $_SESSION["id_cliente"] = $res[0]["id"];
    $_SESSION["nome_cliente"] = $res[0]["nome"];
    $_SESSION["telefone_cliente"] = $res[0]["telefone"];
}

echo 'Salvo com Sucesso';
?>
