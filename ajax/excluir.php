<?php
require_once("../sistema/conexao.php");

$id = @$_POST['id'];

if (empty($id)) {
    echo 'ID do agendamento não fornecido!';
    exit();
}

// Iniciar uma transação para garantir que ambas as operações sejam executadas com sucesso
$pdo->beginTransaction();

try {
    // Excluir o registro na tabela `receber` associado ao agendamento
    $query = $pdo->prepare("DELETE FROM receber WHERE id_agendamento = :id_agendamento");
    $query->execute(['id_agendamento' => $id]);

    // Excluir o agendamento
    $query = $pdo->prepare("DELETE FROM agendamentos WHERE id = :id");
    $query->execute(['id' => $id]);

    // Confirmar a transação
    $pdo->commit();

    echo 'Cancelado com Sucesso';
} catch (Exception $e) {
    // Em caso de erro, desfazer a transação
    $pdo->rollBack();
    echo 'Erro ao cancelar o agendamento: ' . $e->getMessage();
}
?>