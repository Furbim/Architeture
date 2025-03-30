<?php
require_once("../../conexao.php");

$dataInicial = $_POST['dataInicial'];
$dataFinal = $_POST['dataFinal'];
$filtro = $_POST['filtro'] ?? '';

$query = $pdo->prepare("SELECT * FROM receber WHERE data BETWEEN :dataInicial AND :dataFinal AND (:filtro = '' OR descricao = :filtro) ORDER BY data");
$query->bindValue(':dataInicial', $dataInicial);
$query->bindValue(':dataFinal', $dataFinal);
$query->bindValue(':filtro', $filtro);
$query->execute();
$itens = $query->fetchAll(PDO::FETCH_ASSOC);

$total = 0;
foreach($itens as $item) {
    $total += $item['valor'];
}

header('Content-Type: application/json');
echo json_encode([
    'itens' => $itens,
    'total' => $total,
    'periodo' => [
        'dataInicial' => $dataInicial,
        'dataFinal' => $dataFinal
    ],
    'filtro' => $filtro ?: 'Todos'
]);