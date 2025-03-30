<?php
require_once("../sistema/conexao.php");
@session_start();
$usuario = @$_SESSION['id'];

$funcionario = @$_POST['funcionario'];
$data = @$_POST['data'];
$hora_rec = @$_POST['hora'];

// Verificar se o funcionário foi informado
if (empty($funcionario)) {
	echo 'Funcionário não informado!';
	exit();
}

// Verificar se a data foi informada
if (empty($data)) {
	echo 'Data não informada!';
	exit();
}

// Verificar o dia da semana da data informada
$diasemana = array("Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado");
$diasemana_numero = date('w', strtotime($data));
$dia_procurado = $diasemana[$diasemana_numero];

// Verificar se o funcionário trabalha no dia informado
$query = $pdo->prepare("SELECT * FROM dias WHERE funcionario = :funcionario AND dia = :dia");
$query->execute(['funcionario' => $funcionario, 'dia' => $dia_procurado]);
$res = $query->fetchAll(PDO::FETCH_ASSOC);


if (count($res) == 0) {
	echo 'Este Funcionário não trabalha neste Dia!';
	exit();
}

// Buscar os horários disponíveis para o funcionário
$query = $pdo->prepare("SELECT * FROM horarios WHERE funcionario = :funcionario ORDER BY horario ASC");
$query->execute(['funcionario' => $funcionario]);
$res = $query->fetchAll(PDO::FETCH_ASSOC);

if (count($res) == 0) {
	echo 'Nenhum horário disponível para este funcionário!';
	exit();
}
?>

<div class="row">
	<?php
	foreach ($res as $horario) {
		$hora = $horario['horario'];
		$horaF = date("H:i", strtotime($hora));
		$horaAtual = date("H:i");


		if ($horaAtual < $horaF) {


			// Verificar se o horário já está agendado
			$query2 = $pdo->prepare("SELECT * FROM agendamentos WHERE data = :data AND hora = :hora AND funcionario = :funcionario");
			$query2->execute(['data' => $data, 'hora' => $hora, 'funcionario' => $funcionario]);
			$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);


			// Se o horário não estiver agendado ou for o horário selecionado, exibir o radio button
			if (count($res2) == 0 || $hora_rec == $hora) {
				$checado = ($hora_rec == $hora) ? 'checked' : '';
				?>
				<div class="col-3">
					<div class="form-check">
						<input class="form-check-input" type="radio" name="hora" value="<?php echo $hora ?>" <?php echo $checado ?>
							style="width:17px; height: 17px" required>
						<label class="form-check-label" for="flexRadioDefault1">
							<?php echo $horaF ?>
						</label>
					</div>
				</div>
				<?php

			}
		}
	}
	?>
</div>