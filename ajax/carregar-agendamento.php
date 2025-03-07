<?php
require_once("../sistema/conexao.php");

if (isset($_POST['id'])) {
    $id = $_POST['id'];
    $query = $pdo->query("SELECT clientes.nome AS nome_cliente,
        clientes.telefone AS telefone_cliente,
        agendamentos.data AS data,
        agendamentos.hora AS horario,
        agendamentos.funcionario AS funcionario,
        agendamentos.servico AS servico,
        agendamentos.data AS data

    FROM agendamentos
    INNER JOIN clientes ON clientes.id = agendamentos.cliente
    WHERE agendamentos.id = '$id'");
    $agendamento = $query->fetch(PDO::FETCH_ASSOC);
    echo json_encode($agendamento);
}
?>