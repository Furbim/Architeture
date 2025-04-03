<?php 
$tabela = 'receber';
require_once("../../../conexao.php");
$data_atual = date('Y-m-d');

@session_start();
$usuario_logado = @$_SESSION['id'];

// Verifica se todos os campos necessários foram enviados
if(empty($_POST['cliente_agd']) || empty($_POST['id_agd']) || empty($_POST['funcionario_agd']) || empty($_POST['servico_agd'])) {
    die("Dados incompletos!");
}

// Recupera dados do POST com segurança
$cliente = $_POST['cliente_agd'];
$data_pgto = $_POST['data_pgto'] ?? $data_atual; // Usa data atual se não informada
$id_agd = $_POST['id_agd'];
$valor_serv = $_POST['valor_serv_agd'] ?? 0;
$funcionario = $_POST['funcionario_agd'];
$servico = $_POST['servico_agd'];

// Busca informações do serviço
$query = $pdo->prepare("SELECT * FROM servicos WHERE id = ?");
$query->execute([$servico]);
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if(empty($res)) {
    die("Serviço não encontrado!");
}

$valor = $res[0]['valor'];
$comissao = $res[0]['comissao'] ?? 0;
$descricao = $res[0]['nome'];
$descricao2 = 'Comissão - '.$res[0]['nome'];
$tipo_comissao = $res[0]['tipo_comissao'] ?? 'Porcentagem'; // Adicionado padrão
$dias_retorno = $res[0]['dias_retorno'] ?? 0;

// Calcula valor da comissão
if($tipo_comissao == 'Porcentagem'){
    $valor_comissao = ($comissao * $valor) / 100;
} else {
    $valor_comissao = $comissao;
}

// Verifica se o pagamento está sendo feito
$pago = (strtotime($data_pgto) <= strtotime($data_atual)) ? 'Sim' : 'Não';
$data_pgto2 = ($pago == 'Sim') ? $data_pgto : '';
$usuario_baixa = ($pago == 'Sim') ? $usuario_logado : 0;

// Lança a conta a pagar para a comissão do funcionário (se pago)
if($pago == 'Sim') {
    $query_comissao = $pdo->prepare("INSERT INTO pagar SET 
        descricao = ?, 
        tipo = 'Comissão', 
        valor = ?, 
        data_lanc = ?, 
        data_venc = ?, 
        usuario_lanc = ?, 
        foto = 'sem-foto.jpg', 
        pago = 'Não', 
        funcionario = ?, 
        servico = ?, 
        cliente = ?");
    
    $query_comissao->execute([
        $descricao2, 
        $valor_comissao, 
        $data_pgto, 
        $data_pgto, 
        $usuario_logado, 
        $funcionario, 
        $servico, 
        $cliente
    ]);
}

// Busca dados do cliente
$query_cliente = $pdo->prepare("SELECT * FROM clientes WHERE id = ?");
$query_cliente->execute([$cliente]);
$res_cliente = $query_cliente->fetch(PDO::FETCH_ASSOC);

if(!$res_cliente) {
    die("Cliente não encontrado!");
}

$total_cartoes = $res_cliente['cartoes'] ?? 0;
$quantidade_cartoes = 10; // Defina o valor adequado ou obtenha de alguma configuração

// Atualiza cartões do cliente
$cartoes = ($total_cartoes >= $quantidade_cartoes) ? 0 : $total_cartoes + 1;
$data_retorno = date('Y-m-d', strtotime("+$dias_retorno days", strtotime($data_atual)));

// Antes de inserir na tabela 'receber', verifique se $id_agd existe em 'agendamentos'
$query_verifica_agendamento = $pdo->prepare("SELECT id FROM agendamentos WHERE id = ?");
$query_verifica_agendamento->execute([$id_agd]);
$agendamento_existe = $query_verifica_agendamento->fetch();

if (!$agendamento_existe) {
    die("Agendamento não encontrado!");
}

// Inserir na tabela 'receber' incluindo o 'id_agendamento'
$query_receber = $pdo->prepare("INSERT INTO $tabela SET 
    descricao = ?, 
    tipo = 'Serviço', 
    valor = ?, 
    data_lanc = curDate(), 
    data_venc = ?, 
    data_pgto = ?, 
    usuario_lanc = ?, 
    usuario_baixa = ?, 
    foto = 'sem-foto.jpg', 
    pessoa = ?, 
    pago = ?, 
    servico = ?, 
    funcionario = ?,
    id_agendamento = ?"); // <-- Adicione esta linha

$query_receber->execute([
    $descricao, 
    $valor_serv, 
    $data_pgto, 
    $data_pgto2, 
    $usuario_logado, 
    $usuario_baixa, 
    $cliente, 
    $pago, 
    $servico, 
    $funcionario,
    $id_agd // <-- Passe o ID do agendamento
]);

// Atualiza o agendamento e o cliente
$pdo->prepare("UPDATE agendamentos SET status = 'Concluído' WHERE id = ?")->execute([$id_agd]);
$pdo->prepare("UPDATE clientes SET cartoes = ?, data_retorno = ?, ultimo_servico = ?, alertado = 'Não' WHERE id = ?")
    ->execute([$cartoes, $data_retorno, $servico, $cliente]);

echo 'Salvo com Sucesso';
?>