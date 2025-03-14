<?php 
require_once("conexao.php");

// INSERIR UM USUÁRIO ADMINISTRADOR CASO NÃO EXISTA
$senha = '123';
$senha_crip = md5($senha);

$query = $pdo->query("SELECT * FROM usuarios WHERE nivel = 'Administrador'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);

if ($total_reg == 0) {
    $pdo->query("INSERT INTO usuarios SET nome = 'Admin', email = '$email_sistema', cpf = '000.000.000-00', senha = '$senha', senha_crip = '$senha_crip', nivel = 'Administrador', data = CURDATE(), ativo = 'Sim', foto = 'sem-foto.jpg'");
}

// INSERIR O CARGO ADMINISTRADOR SE NÃO EXISTIR
$query = $pdo->query("SELECT * FROM cargos");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);

if ($total_reg == 0) {
    $pdo->query("INSERT INTO cargos SET nome = 'Administrador'");
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $nome_sistema; ?></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="bg-white p-8 rounded-lg shadow-md w-96">
        <div class="text-center mb-6">
            <img src="img/logo.png" alt="Logo" class="mx-auto w-48">
        </div>

        <form action="autenticar.php" method="post" class="space-y-4">
            <div>
                <input type="text" name="email" placeholder="E-mail ou CPF" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <input type="password" name="senha" placeholder="Senha" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition">Login</button>
        </form>

        <p class="text-center text-sm mt-4">
            <a href="#" data-modal-target="modalRecuperarSenha" class="text-blue-600 hover:underline">Esqueceu a senha?</a>
        </p>
    </div>

    <!-- Modal -->
    <div id="modalRecuperarSenha" class="hidden fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg w-80 shadow-lg">
            <h2 class="text-lg font-semibold mb-4">Recuperar Senha</h2>
            <form id="form-recuperar" method="post">
                <input type="email" name="email" id="email-recuperar" placeholder="Digite seu Email" required class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                <div id="mensagem-recuperar" class="text-center text-sm mt-2"></div>
                <div class="flex justify-end space-x-2 mt-4">
                    <button type="button" id="fechar-modal" class="px-4 py-2 bg-gray-400 text-white rounded-lg">Fechar</button>
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Recuperar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.querySelector("[data-modal-target]").addEventListener("click", function () {
            document.getElementById("modalRecuperarSenha").classList.remove("hidden");
        });

        document.getElementById("fechar-modal").addEventListener("click", function () {
            document.getElementById("modalRecuperarSenha").classList.add("hidden");
        });

        document.getElementById("form-recuperar").addEventListener("submit", function (event) {
            event.preventDefault();
            var formData = new FormData(this);

            fetch("recuperar-senha.php", {
                method: "POST",
                body: formData
            })
            .then(response => response.text())
            .then(mensagem => {
                var mensagemDiv = document.getElementById("mensagem-recuperar");
                mensagemDiv.classList.remove("text-red-500", "text-green-500");

                if (mensagem.trim() === "Recuperado com Sucesso") {
                    mensagemDiv.classList.add("text-green-500");
                    mensagemDiv.textContent = "Sua senha foi enviada para o email.";
                    document.getElementById("email-recuperar").value = "";
                } else {
                    mensagemDiv.classList.add("text-red-500");
                    mensagemDiv.textContent = mensagem;
                }
            });
        });
    </script>
</body>
</html> 
