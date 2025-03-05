<?php 
require_once("../sistema/conexao.php");
$tabela = 'clientes';

if (!isset($_SESSION)) {
	session_start();
}

$email = $_POST['email'];
$senha = $_POST['senha'];

// Buscar usuário pelo e-mail
$query = $pdo->prepare("SELECT * FROM $tabela WHERE email = :email");
$query->bindValue(":email", $email);
$query->execute();
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0) {
    // Verifica a senha
    if (password_verify($senha, $res[0]["senha"])) { 
        $_SESSION["id_cliente"] = $res[0]["id"];
        $_SESSION["nome_cliente"] = $res[0]["nome"];
        $_SESSION["telefone_cliente"] = $res[0]["telefone"];
        $_SESSION["email"] = $res[0]["email"];

        // Redireciona para a área do cliente
        header("Location: ../agendamentos.php");
        exit();
    } else {
        echo '<script>alert("Email ou senha incorretos!"); window.location.href="login.php";</script>';
        exit();
    }
} else {
    echo '<script>alert("Não existe nenhum usuário com esse email cadastrado!"); window.location.href="login.php";</script>';
    exit();
}
?>
