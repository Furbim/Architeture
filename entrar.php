<?php
require_once("cabecalho.php");

if (!isset($_SESSION)) session_start();

if (isset($_SESSION["id_cliente"])) header("Location: agendamentos.php");
?>

<style>
    .form-container {
        max-width: 400px;
        margin: auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        height: 100%;
    }
    .toggle-form {
        text-align: center;
        margin-top: 10px;
    }
</style>

<div class="container mt-5">
    <div class="form-container">
        <h3 class="text-center" id="form-title">Login</h3>
        <form id="login-form" method="post" action="ajax/login.php">
            <div class="form-group">
                <input type="email" class="form-control" name="email" placeholder="Seu Email" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="senha" placeholder="Sua Senha" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Entrar</button>
        </form>

        <form id="cadastro-form" method="post" action="ajax/cadastrar.php" style="display: none;">
            <div class="form-group">
                <input type="text" class="form-control" name="nome" placeholder="Seu Nome" value="<?= $_POST['nome'] ?? '' ?>" required>
            </div>
            <div class="form-group">
                <input type="tel" class="form-control" id="telefone" name="telefone" placeholder="Seu Telefone" value="<?= $_POST['telefone'] ?? '' ?>" required>
            </div>
            <div class="form-group">
                <input type="email" class="form-control" name="email" placeholder="Seu Email" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="senha" placeholder="Sua Senha" required>
            </div>
            <button type="submit" class="btn btn-success btn-block">Cadastrar</button>
        </form>

        <div class="toggle-form">
            <a href="#" id="toggle-link">Não tem conta? Cadastre-se</a>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var loginForm = document.getElementById("login-form");
        var cadastroForm = document.getElementById("cadastro-form");
        var title = document.getElementById("form-title");
        var toggleLink = document.getElementById("toggle-link");

        <?php if (!empty($_POST['nome']) && !empty($_POST['telefone'])): ?>
            loginForm.style.display = "none";
            cadastroForm.style.display = "block";
            title.innerText = "Cadastro";
            toggleLink.innerText = "Já tem conta? Faça login";
        <?php endif; ?>

        toggleLink.addEventListener("click", function (event) {
            event.preventDefault();
            var isLoginVisible = loginForm.style.display !== "none";
            loginForm.style.display = isLoginVisible ? "none" : "block";
            cadastroForm.style.display = isLoginVisible ? "block" : "none";
            title.innerText = isLoginVisible ? "Cadastro" : "Login";
            toggleLink.innerText = isLoginVisible ? "Já tem conta? Faça login" : "Não tem conta? Cadastre-se";
        });
    });
</script>

<?php require_once("rodape.php"); ?>
