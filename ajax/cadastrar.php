<?php 
require_once("../sistema/conexao.php");


session_start(); // Certifique-se de iniciar a sessão antes de qualquer saída

$tabela = 'clientes';

// Verificar se os dados foram enviados corretamente
if (!isset($_POST['nome']) || !isset($_POST['telefone']) || !isset($_POST['email'])  || !isset($_POST['senha'])) {
    echo 'Erro: Preencha corretamente todos os dados!';
    exit();
}

$nome = $_POST['nome'];
$telefone = $_POST['telefone'];
$email = $_POST['email'];
$senha = $_POST['senha'];

// Validar telefone
$query = $pdo->prepare("SELECT * FROM $tabela WHERE telefone = :telefone OR email = :email");
$query->bindValue(":telefone", $telefone);
$query->bindValue(":email", $email);
$query->execute();
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0) {
    echo 'Você já está cadastrado!';
    exit();
}

$senha = password_hash($senha, PASSWORD_BCRYPT);
// Inserir novo cliente
$query = $pdo->prepare("INSERT INTO $tabela (nome, telefone, data_cad, cartoes, alertado, email, senha) VALUES (:nome, :telefone, CURDATE(), 0, 'Não', :email, :senha)");
$query->bindValue(":nome", $nome);
$query->bindValue(":telefone", $telefone);
$query->bindValue(":email", $email);
$query->bindValue(":senha", $senha);
$query->execute();

echo '<script> alert("Cadastrado com sucesso!")</script>';
header('Location: ../entrar.php');
?>
