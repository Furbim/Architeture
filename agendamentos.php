<?php
require_once("cabecalho.php");
$data_atual = date('Y-m-d');

if (!isset($_SESSION)) {
	session_start();
}

$telefone = '';
$nome = '';



?>
<style type="text/css">
	.sub_page .hero_area {
		min-height: auto;
	}
</style>

</div>

<?php

if (isset($_SESSION['id_cliente'])) {
	$nome = $_SESSION['nome_cliente'];
	$telefone = $_SESSION['telefone_cliente'];
} else {

	header("Location: entrar.php");

}



?>

<div class="footer_section" style="background: #5a8e94;">
	<div class="container">
		<div class="footer_content ">
			<?php
			$id_cliente = $_SESSION['id_cliente'];



			// Verifica se já existe um agendamento
			$query = $pdo->query("SELECT 
				agendamentos.id AS id_agendamento, 
				agendamentos.hora AS horario, 
				usuarios.nome AS nome_funcionario, 
				servicos.nome AS nome_servico, 
				servicos.valor AS valor_servico, 
				agendamentos.data AS dia
			FROM agendamentos
			INNER JOIN usuarios ON usuarios.id = agendamentos.funcionario
			INNER JOIN servicos ON servicos.id = agendamentos.servico
			WHERE agendamentos.cliente = '$id_cliente' 
			ORDER BY agendamentos.data DESC");
			$agendamentos = $query->fetchAll(PDO::FETCH_ASSOC);

			if (count($agendamentos) > 0) {
				$temAgendamentos = true;
				// Exibe os agendamentos
				foreach ($agendamentos as $agendamento) {
					$data = date('d/m/Y', strtotime($agendamento['dia']));
					$hora = $agendamento['horario'];
					$funcionario = $agendamento['nome_funcionario'];
					$servico = $agendamento['nome_servico'];
					$valor = number_format($agendamento['valor_servico'], 2, ',', '.');
					$id_agendamentos = $agendamento['id_agendamento'];
					
					echo "<div class='agendamento' id='lista-agendamentos'>
						<p>Data: $data</p>
						<p>Hora: $hora</p>
						<p>Funcionário: $funcionario</p>
						<p>Serviço: $servico - R$ $valor</p>
						<button onclick='editarAgendamento($id_agendamentos)'>Editar</button>
						<button onclick='excluirAgendamento($id_agendamentos)'>Excluir</button>
					</div>";
				}
			} else {
				$temAgendamentos = false;
			}

			?>

			<?php
			if ($temAgendamentos) {
				echo '<form id="form-agenda" method="post" style="margin-top: -25px !important; display: none; ">';
			} else {
				echo '<form id="form-agenda" method="post" style="margin-top: -25px !important;">';
			}
			?>
			
				<div class="footer_form footer-col">
					<div class="form-group">
						<input onkeyup="buscarNome()" class="form-control" type="text" name="telefone" id="telefone"
							value='<?php echo $telefone; ?>' placeholder="Seu Telefone DDD + número" required />
					</div>

					<div class="form-group">
						<input onclick="buscarNome()" class="form-control" type="text" name="nome" id="nome"
							value="<?php echo $nome; ?>" placeholder="Seu Nome" required />
					</div>

					<div class="form-group">
						<input onchange="mudarFuncionario()" class="form-control" type="date" name="data" id="data"
							value="<?php echo $data_atual ?>" required />
					</div>


					<div class="form-group">
						<select class="form-control sel2" id="funcionario" name="funcionario" style="width:100%;"
							onchange="mudarFuncionario()" required>
							<option value=""><?php echo $texto_agendamento ?></option>
							<?php
							$query = $pdo->query("SELECT * FROM usuarios WHERE atendimento = 'Sim' AND barbearia_id = '$barbershop_id' ORDER BY id desc");
							$res = $query->fetchAll(PDO::FETCH_ASSOC);
							$total_reg = @count($res);
							if ($total_reg > 0) {
								for ($i = 0; $i < $total_reg; $i++) {
									foreach ($res[$i] as $key => $value) {
									}
									echo '<option value="' . $res[$i]['id'] . '">' . $res[$i]['nome'] . '</option>';
								}
							}
							?>


						</select>
					</div>


					<div class="form-group">
						<div id="listar-horarios">

						</div>
					</div>


					<div class="form-group">
						<select onchange="mudarServico()" class="form-control sel2" id="servico" name="servico"
							style="width:100%;" required>
							<option value="">Selecione um Serviço</option>

							<?php
							$query = $pdo->query("SELECT * FROM servicos WHERE barbearia_id = $barbershop_id ORDER BY nome asc");
							$res = $query->fetchAll(PDO::FETCH_ASSOC);
							$total_reg = @count($res);
							if ($total_reg > 0) {
								for ($i = 0; $i < $total_reg; $i++) {
									foreach ($res[$i] as $key => $value) {
									}
									$valor = $res[$i]['valor'];
									$valorF = number_format($valor, 2, ',', '.');

									echo '<option value="' . $res[$i]['id'] . '">' . $res[$i]['nome'] . ' - R$ ' . $valorF . '</option>';
								}
							}
							?>


						</select>
					</div>


					<div class="form-group">
						<input maxlength="100" type="text" class="form-control" name="obs" id="obs"
							placeholder="Observações caso exista alguma.">
					</div>

					<button onclick="salvar()" class="botao-verde" type="submit" style="width:100%;">
						<span id='botao_salvar'>Confirmar Agendamento</span>

					</button>

					<br><br>
					<small>
						<div id="mensagem" align="center"></div>
					</small>

					<input type="hidden" id="id_agendamento" name="id">


				</div>



			</form>

			<div id="listar-cartoes" style="margin-top: -30px">

			</div>


		</div>


	</div>


</div>




<?php require_once("rodape.php") ?>





<!-- Modal Depoimentos -->
<div class="modal fade" id="modalExcluir" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Excluir Agendamento</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn-fechar-excluir">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form id="form-excluir">
				<div class="modal-body">
					<span id="msg-excluir"></span>
					<input type="hidden" name="id" id="id_excluir">
					<br>
					<small>
						<div id="mensagem-excluir" align="center"></div>
					</small>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger">Excluir</button>
				</div>
			</form>
		</div>
	</div>
</div>






<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<style type="text/css">
	.select2-selection__rendered {
		line-height: 45px !important;
		font-size: 16px !important;
		color: #000 !important;

	}

	.select2-selection {
		height: 45px !important;
		font-size: 16px !important;
		color: #000 !important;

	}
</style>



<script type="text/javascript">
	$(document).ready(function () {
		document.getElementById("botao_editar").style.display = "none";
		document.getElementById("botao_excluir").style.display = "none";
		$('.sel2').select2({

		});
	});
</script>


<script type="text/javascript">

	function mudarFuncionario() {
		var funcionario = $('#funcionario').val();
		var data = $('#data').val();
		console.log(data)
		var hora = $('#hora_rec').val();
		listarHorarios(funcionario, data, hora);
		listarFuncionario();

	}
</script>

<script type="text/javascript">
	function listarHorarios(funcionario, data, hora) {


		$.ajax({
			url: "ajax/listar-horarios.php",
			method: 'POST',
			data: { funcionario, data, hora },
			dataType: "text",

			success: function (result) {
				$("#listar-horarios").html(result);
			}
		});
	}
</script>



<script type="text/javascript">

	function buscarNome(telefone) {
		var tel = telefone;
		listarCartoes(tel);

		$.ajax({
			url: "ajax/listar-nome.php",
			method: 'POST',
			data: { tel },
			dataType: "text",

			success: function (result) {
				var split = result.split("*");
				console.log(split[3])

				if (split[2] == "" || split[2] == undefined) {

				} else {
					$("#funcionario").val(parseInt(split[2])).change();
				}

				$("#nome").val(split[0]);
				$("#data_oculta").val(split[1]);
				$("#data").val($("#data_oculta").val());
				$("#id").val(split[3]);
				$("#hora_rec").val(split[4]);
				$("#obs").val(split[6]);
				$("#id_excluir").val(split[3]);
				$("#nome_func").val(split[8]);
				$("#data_rec").val(split[7]);
				$("#nome_serv").val(split[9]);

				$("#msg-excluir").text('Deseja Realmente excluir esse agendamento feito para o dia ' + split[7] + ' às ' + split[4]);


				mudarFuncionario()



			}
		});




	}
</script>


<script type="text/javascript">
	function editarAgendamento(id) {
    $.ajax({
        url: "ajax/carregar-agendamento.php",
        method: 'POST',
        data: { id },
        dataType: "json",
        success: function (data) {
            // Preenche os campos do formulário com os dados do agendamento
            $("#id_agendamento").val(id);
            $("#nome").val(data.nome_cliente);
            $("#telefone").val(data.telefone_cliente);
            $("#data").val(data.data);
			$("#hora_rec").val(data.horario);
            $("#funcionario").val(data.funcionario).change();
            $("#servico").val(data.servico).change();
            $("#obs").val(data.obs);

            // Mostra o formulário de edição
            $("#form-agenda").show();

            // Oculta a lista de agendamentos (se necessário)
            $("#lista-agendamentos").hide();

            // Muda o botão de salvar para "Atualizar Agendamento"
            $("#botao_salvar").text('Atualizar Agendamento');

            // Carrega os horários corretamente
            listarHorarios(data.funcionario, data.data, data.horario);
        },
        error: function (xhr, status, error) {
            console.error("Erro ao carregar agendamento:", error);
        }
    });
}

	function excluirAgendamento(id) {
		$("#id_excluir").val(id);
		$("#msg-excluir").text('Deseja realmente excluir este agendamento?');
		$("#modalExcluir").modal('show');
	}
</script>



<script type="text/javascript">

	function salvar() {
		$('#id').val('');
	}
</script>




<script>

	$("#form-agenda").submit(function () {
		event.preventDefault();


		var formData = new FormData(this);

		$.ajax({
			url: "ajax/agendar.php",
			type: 'POST',
			data: formData,

			success: function (mensagem) {
				$('#mensagem').text('');
				$('#mensagem').removeClass()
				if (mensagem.trim() == "Agendado com Sucesso") {
					$('#mensagem').text(mensagem)
					buscarNome()

					var nome = $('#nome').val();
					var data = $('#data').val();
					var hora = document.querySelector('input[name="hora"]:checked').value;
					var obs = $('#obs').val();
					var nome_func = $('#nome_func').val();
					var nome_serv = $('#nome_serv').val();

					var dataF = data.split("-");
					var dia = dataF[2];
					var mes = dataF[1];
					var ano = dataF[0];
					var dataFormatada = dia + '/' + mes + '/' + ano;

					var horaF = hora.split(':');
					var horaH = horaF[0];
					var horaM = horaF[1];
					var horaFormatada = horaH + ':' + horaM;

					var msg_agendamento = "<?= $msg_agendamento ?>";

					if (msg_agendamento == 'Sim') {

						let a = document.createElement('a');
						a.target = '_blank';
						a.href = 'http://api.whatsapp.com/send?1=pt_BR&phone=<?= $tel_whatsapp ?>&text= _Novo Agendamento_ %0A Funcionário: *' + nome_func + '* %0A Serviço: *' + nome_serv + '* %0A Data: *' + dataFormatada + '* %0A Hora: *' + horaFormatada + '* %0A Cliente: *' + nome + '*  %0A %0A ' + obs;
						a.click();
						return;

					}


				}


				else if (mensagem.trim() == "Editado com Sucesso") {
					$('#mensagem').text(mensagem)
					//buscarNome()

					var nome = $('#nome').val();
					var data = $('#data').val();
					var hora = document.querySelector('input[name="hora"]:checked').value;
					var obs = $('#obs').val();
					var nome_func = $('#nome_func').val();
					var nome_serv = $('#nome_serv').val();

					var dataF = data.split("-");
					var dia = dataF[2];
					var mes = dataF[1];
					var ano = dataF[0];
					var dataFormatada = dia + '/' + mes + '/' + ano;

					var horaF = hora.split(':');
					var horaH = horaF[0];
					var horaM = horaF[1];
					var horaFormatada = horaH + ':' + horaM;

					var msg_agendamento = "<?= $msg_agendamento ?>";

					if (msg_agendamento == 'Sim') {

						let a = document.createElement('a');
						a.target = '_blank';
						a.href = 'http://api.whatsapp.com/send?1=pt_BR&phone=<?= $tel_whatsapp ?>&text= *Atenção:* _Agendamento Editado_ %0A Funcionário: *' + nome_func + '* %0A Serviço: *' + nome_serv + '* %0A Data: *' + dataFormatada + '* %0A Hora: *' + horaFormatada + '* %0A Cliente: *' + nome + '*  %0A %0A ' + obs + '';
						a.click();
						return;

					}


				}


				else {
					//$('#mensagem').addClass('text-danger')
					$('#mensagem').text(mensagem)
				}

			},

			cache: false,
			contentType: false,
			processData: false,

		});


		window.location.reload();
	});

</script>




<script>

	$("#form-excluir").submit(function (event) {
		event.preventDefault();
		var formData = new FormData(this);

		$.ajax({
			url: "ajax/excluir.php",
			type: 'POST',
			data: formData,
			success: function (mensagem) {
				$('#mensagem-excluir').text('');
				$('#mensagem-excluir').removeClass();
				if (mensagem.trim() == "Cancelado com Sucesso") {
					$('#btn-fechar-excluir').click();
					$('#mensagem').text(mensagem);
					// Atualiza a lista de agendamentos
					location.reload(); // Recarrega a página para mostrar a lista atualizada
				} else {
					$('#mensagem-excluir').text(mensagem);
				}
			},
			cache: false,
			contentType: false,
			processData: false,
		});
	});

</script>


<script type="text/javascript">

	function listarCartoes(tel) {

		$.ajax({
			url: "ajax/listar-cartoes.php",
			method: 'POST',
			data: { tel },
			dataType: "text",

			success: function (result) {
				$("#listar-cartoes").html(result);
			}
		});

	}
</script>





<script type="text/javascript">
	function listarFuncionario() {
		var func = $("#funcionario").val();

		$.ajax({
			url: "ajax/listar-funcionario.php",
			method: 'POST',
			data: { func },
			dataType: "text",

			success: function (result) {
				$("#nome_func").val(result);
			}
		});
	}
</script>


<script type="text/javascript">
	function mudarServico() {
		var serv = $("#servico").val();

		$.ajax({
			url: "ajax/listar-servico.php",
			method: 'POST',
			data: { serv },
			dataType: "text",

			success: function (result) {
				$("#nome_serv").val(result);
			}
		});
	}
</script>