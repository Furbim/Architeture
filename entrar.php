<?php
require_once("cabecalho.php");

if (!isset($_SESSION)) {
    session_start();
}
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
        <form id="login-form" method="post" action="processa_login.php">
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
                <input type="text" class="form-control" name="nome" placeholder="Seu Nome" required>
            </div>
            <div class="form-group">
                <input type="tel" class="form-control" id="telefone" name="telefone" placeholder="Seu Telefone" required>
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
    document.getElementById("toggle-link").addEventListener("click", function(event) {
        event.preventDefault();
        var loginForm = document.getElementById("login-form");
        var cadastroForm = document.getElementById("cadastro-form");
        var title = document.getElementById("form-title");
        if (loginForm.style.display === "none") {
            loginForm.style.display = "block";
            cadastroForm.style.display = "none";
            title.innerText = "Login";
            this.innerText = "Não tem conta? Cadastre-se";
        } else {
            loginForm.style.display = "none";
            cadastroForm.style.display = "block";
            title.innerText = "Cadastro";
            this.innerText = "Já tem conta? Faça login";
        }
    });
</script>


<?php require_once("rodape.php"); ?>
