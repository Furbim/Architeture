<?php
if(!isset($_SESSION)){
    @session_start();
}
require_once("../sistema/conexao.php");

date_default_timezone_set('America/Sao_Paulo'); // Garante que o fuso horário está correto

// Verifica se a conexão está ativa
if (!$pdo) {
    die("Erro na conexão com o banco de dados!");
}


if(!isset($_SESSION['id_cliente'])){
    header('Location: agendamentos.php');
}

$funcionario = $_POST['funcionario'];
$hora = $_POST['hora'];
$servico = $_POST['servico'];
$obs = $_POST['obs'];
$data = $_POST['data'];
$id = $_POST['id'];
$id_cliente = $_SESSION['id_cliente'];

if (empty($data) || empty($hora)) {
    echo 'Data e horário são obrigatórios!';
    exit();
}

if (strpos($data, '/') !== false) {
    $dataFormatada = DateTime::createFromFormat('d/m/Y', $data);
    if ($dataFormatada) {
        $data = $dataFormatada->format('Y-m-d');
    } else {
        echo 'Formato de data inválido!';
        exit();
    }
}

$hora = trim($hora);
if (strlen($hora) == 5) { 
    $hora .= ':00';
}

$dataHoraAgendamento = "$data $hora";
$timestampAtual = strtotime(date('Y-m-d H:i:s'));
$timestampAgendamento = strtotime($dataHoraAgendamento);

if ($timestampAgendamento < $timestampAtual) {
    echo 'Não é possível agendar para um horário que já passou!';
    exit();
}



// Verificar se o horário já está ocupado
$query = $pdo->prepare("SELECT * FROM agendamentos WHERE data = :data AND hora = :hora AND funcionario = :funcionario");
$query->execute(['data' => $data, 'hora' => $hora, 'funcionario' => $funcionario]);
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0 && $res[0]['id'] != $id) {
    echo 'Este horário não está disponível!';
    exit();
}

if (empty($id)) {
    // Inserir novo agendamento
    $query = $pdo->prepare("INSERT INTO agendamentos (funcionario, cliente, hora, data, usuario, status, obs, data_lanc, servico) 
                            VALUES (:funcionario, :cliente, :hora, :data, '0', 'Agendado', :obs, CURDATE(), :servico)");
    $query->execute([
        'funcionario' => $funcionario,
        'cliente' => $id_cliente,
        'hora' => $hora,
        'data' => $data,
        'obs' => $obs,
        'servico' => $servico
    ]);
    $id_agendamento = $pdo->lastInsertId(); // Captura o ID do agendamento inserido

    echo 'Agendado com Sucesso';
} else {

    // Verificar se o horário já está ocupado
    $query = $pdo->prepare("SELECT * FROM agendamentos WHERE id = :id AND cliente = :cliente");
    $query->execute(['id' => $id, 'cliente' => $id_cliente]);
    $res = $query->fetchAll(PDO::FETCH_ASSOC);

    if (count($res) == 0 ) {
        echo 'Você não pode editar esse agendamento!';
        exit();
    }

    // Atualizar agendamento existente
    $query = $pdo->prepare("UPDATE agendamentos SET funcionario = :funcionario, hora = :hora, data = :data, usuario = '0', status = 'Agendado', obs = :obs, data_lanc = CURDATE(), servico = :servico 
                            WHERE id = :id");
    $query->execute([
        'funcionario' => $funcionario,
        'hora' => $hora,
        'data' => $data,
        'obs' => $obs,
        'servico' => $servico,
        'id' => $id
    ]);

    echo 'Editado com Sucesso';
}
?>