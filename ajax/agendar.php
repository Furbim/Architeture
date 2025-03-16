<?php
require_once("../sistema/conexao.php");

date_default_timezone_set('America/Sao_Paulo'); // Garante que o fuso horário está correto

// Verifica se a conexão está ativa
if (!$pdo) {
    die("Erro na conexão com o banco de dados!");
}

$telefone = $_POST['telefone'] ?? '';
$nome = $_POST['nome'] ?? '';
$funcionario = $_POST['funcionario'] ?? '';
$hora = $_POST['hora'] ?? '';
$servico = $_POST['servico'] ?? '';
$obs = $_POST['obs'] ?? '';
$data = $_POST['data'] ?? '';
$id = $_POST['id'] ?? '';

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

// Verificar se o cliente já existe pelo telefone
$query = $pdo->prepare("SELECT * FROM clientes WHERE telefone LIKE :telefone");
$query->execute(['telefone' => $telefone]);
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) > 0) {
    $id_cliente = $res[0]['id'];
} else {
    // Caso o cliente não exista, retornar a página de login
    header('Location: agendamentos.php');
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

    // Obter informações do serviço
    $query = $pdo->prepare("SELECT * FROM servicos WHERE id = :servico");
    $query->execute(['servico' => $servico]);
    $res = $query->fetch(PDO::FETCH_ASSOC);

    if ($res) {
        $nome_servico = $res['nome'];
        $valor_serv = $res['valor'];

        // Inserir pagamento
        $query = $pdo->prepare("INSERT INTO receber (descricao, tipo, valor, data_lanc, data_venc, data_pgto, usuario_lanc, usuario_baixa, foto, pessoa, pago, servico, funcionario, id_agendamento)
                                VALUES (:descricao, 'Serviço', :valor, CURDATE(), :data_venc, :data_pgto, :usuario_lanc, :usuario_baixa, 'sem-foto.jpg', :pessoa, 'Sim', :servico, :funcionario, :id_agendamento)");
        $query->execute([
            'descricao' => $nome_servico,
            'valor' => $valor_serv,
            'data_venc' => $data,
            'data_pgto' => $data,
            'usuario_lanc' => $funcionario,
            'usuario_baixa' => $funcionario,
            'pessoa' => $id_cliente,
            'servico' => $servico,
            'funcionario' => $funcionario,
            'id_agendamento' => $id_agendamento
        ]);
    }

    echo 'Agendado com Sucesso';
} else {
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

    // Obter informações do serviço
    $query = $pdo->prepare("SELECT * FROM servicos WHERE id = :servico");
    $query->execute(['servico' => $servico]);
    $res = $query->fetch(PDO::FETCH_ASSOC);

    if ($res) {
        $nome_servico = $res['nome'];
        $valor_serv = $res['valor'];

        // Atualizar a tabela receber
        $query = $pdo->prepare("UPDATE receber SET descricao = :descricao, valor = :valor, data_venc = :data_venc, data_pgto = :data_pgto, usuario_lanc = :usuario_lanc, usuario_baixa = :usuario_baixa, servico = :servico, funcionario = :funcionario 
                                WHERE id_agendamento = :id_agendamento");
        $query->execute([
            'descricao' => $nome_servico,
            'valor' => $valor_serv,
            'data_venc' => $data,
            'data_pgto' => $data,
            'usuario_lanc' => $funcionario,
            'usuario_baixa' => $funcionario,
            'servico' => $servico,
            'funcionario' => $funcionario,
            'id_agendamento' => $id
        ]);
    }

    echo 'Editado com Sucesso';
}
?>