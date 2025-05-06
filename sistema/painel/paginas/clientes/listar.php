<?php 
require_once("../../../conexao.php");
$tabela = 'clientes';
$data_atual = date('Y-m-d');

$query = $pdo->query("
	SELECT DISTINCT c.id, c.nome, c.telefone, c.email, c.data_nasc, c.data_cad, 
       c.endereco, c.cartoes, c.data_retorno, c.ultimo_servico
FROM clientes AS c
INNER JOIN agendamentos AS a ON c.id = a.cliente
INNER JOIN usuarios AS u ON a.funcionario = u.id
WHERE u.barbearia_id = $barbershop_id
ORDER BY c.id DESC
");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if($total_reg > 0){

echo <<<HTML
	<small>
	<table class="table table-hover" id="tabela">
	<thead> 
	<tr> 
	<th>Nome</th>	
	<th class="esc">Telefone</th> 
	<th class="esc">Email</th> 	
	<th class="esc">Cadastro</th> 	
	<th class="esc">Nascimento</th> 
	<th class="esc">Retorno</th> 
	<th class="esc">Cartões</th> 
	<th>Ações</th>
	</tr> 
	</thead> 
	<tbody>	
HTML;

for($i=0; $i < $total_reg; $i++){
	foreach ($res[$i] as $key => $value){}
	$id = $res[$i]['id'];
	$nome = $res[$i]['nome'];	
	$data_nasc = $res[$i]['data_nasc'];
	$data_cad = $res[$i]['data_cad'];	
	$telefone = $res[$i]['telefone'];
	$endereco = $res[$i]['endereco'];
	$cartoes = $res[$i]['cartoes'];
	$data_retorno = $res[$i]['data_retorno'];
	$ultimo_servico = $res[$i]['ultimo_servico'];
	$email = $res[$i]['email'];

	$data_cadF = implode('/', array_reverse(explode('-', $data_cad)));
	$data_nascF = implode('/', array_reverse(explode('-', $data_nasc)));
	$data_retornoF = implode('/', array_reverse(explode('-', $data_retorno)));
	
	if($data_nascF == '00/00/0000'){
		$data_nascF = 'Sem Lançamento';
	}
	
	
	$whats = '55'.preg_replace('/[ ()-]+/' , '' , $telefone);

	$query2 = $pdo->query("SELECT * FROM servicos where id = '$ultimo_servico'");
	$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
	if(@count($res2) > 0){
		$nome_servico = $res2[0]['nome'];
	}else{
		$nome_servico = 'Nenhum!';
	}

	if($data_retorno != "" and strtotime($data_retorno) <  strtotime($data_atual)){
		$classe_retorno = 'text-danger';
	}else{
		$classe_retorno = '';
	}
	



echo <<<HTML
<tr class="">
<td>{$nome}</td>
<td class="esc">{$telefone}</td>
<td class="esc">{$email}</td>
<td class="esc">{$data_cadF}</td>
<td class="esc">{$data_nascF}</td>
<td class="esc {$classe_retorno}">{$data_retornoF}</td>
<td class="esc">{$cartoes}</td>
<td>
	<big><a href="#" onclick="mostrar('{$nome}', '{$telefone}', '{$cartoes}', '{$data_cadF}', '{$data_nascF}', '{$endereco}', '{$data_retornoF}', '{$nome_servico}')" title="Ver Dados"><i class="fa fa-info-circle text-secondary"></i></a></big>
	<big><a href="http://api.whatsapp.com/send?1=pt_BR&phone=$whats&text=" target="_blank" title="Abrir Whatsapp"><i class="fa fa-whatsapp verde"></i></a></big>
</td>
</tr>
HTML;

}

echo <<<HTML
</tbody>
<small><div align="center" id="mensagem-excluir"></div></small>
</table>
</small>
HTML;


}else{
	echo '<small>Não possui nenhum registro Cadastrado!</small>';
}

?>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded",  function () {
    $('#tabela').DataTable({
    		"ordering": false,
			"stateSave": true
    	});
    $('#tabela_filter label input').focus();
} );
</script>



<script type="text/javascript">
	function mostrar(nome, telefone, cartoes, data_cad, data_nasc, endereco, retorno, servico){

		$('#nome_dados').text(nome);		
		$('#data_cad_dados').text(data_cad);
		$('#data_nasc_dados').text(data_nasc);
		$('#cartoes_dados').text(cartoes);
		$('#telefone_dados').text(telefone);
		$('#endereco_dados').text(endereco);
		$('#retorno_dados').text(retorno);		
		$('#servico_dados').text(servico);

		$('#modalDados').modal('show');
	}
</script>