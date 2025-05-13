<?php 
require_once("../../../conexao.php");
$tabela = 'cargos';

$id = $_POST['id'];
$nome = $_POST['nome'];



//validar nome
$query = $pdo->query("SELECT * from $tabela where nome = '$nome' and barbearia_id = $barbershop_id");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
if(@count($res) > 0 and $id != $res[0]['id']){
	echo 'Nome já Cadastrado, escolha outro!!';
	exit();
}


if($id == ""){
	$query = $pdo->prepare("INSERT INTO $tabela (nome,barbearia_id) VALUES nome = :nome, barbearia_id = $barbershop_id");
}else{
	$query = $pdo->prepare("UPDATE $tabela SET nome = :nome WHERE id = '$id'");
}

$query->bindValue(":nome", "$nome");
$query->execute();

echo 'Salvo com Sucesso';
 ?>