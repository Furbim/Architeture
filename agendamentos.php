<?php
if (!isset($_SESSION)) {
	session_start();
}
require_once("cabecalho.php");

$data_atual = date('Y-m-d');
$telefone = $nome = '';

if (!isset($_SESSION['id_cliente'])) {
	header("Location: entrar.php");
	exit();
}

$nome = $_SESSION['nome_cliente'];
$telefone = $_SESSION['telefone_cliente'];
$id_cliente = $_SESSION['id_cliente'];


$query = $pdo->prepare("SELECT 
        agendamentos.id AS id_agendamento, 
        agendamentos.hora AS horario, 
        usuarios.nome AS nome_funcionario, 
        servicos.nome AS nome_servico, 
        servicos.valor AS valor_servico, 
        agendamentos.data AS dia
    FROM agendamentos
    INNER JOIN usuarios ON usuarios.id = agendamentos.funcionario
    INNER JOIN servicos ON servicos.id = agendamentos.servico
    WHERE agendamentos.cliente = :id_cliente AND agendamentos.status = 'Agendado'
    ORDER BY agendamentos.data DESC;");

$query->execute(['id_cliente' => $id_cliente]);
$agendamentos = $query->fetchAll(PDO::FETCH_ASSOC);


$temAgendamentos = count($agendamentos) > 0;

?>

<style type="text/css">
	.sub_page .hero_area {
		min-height: auto;
	}
</style>

<div class="footer_section" style="background: #5a8e94;">
	<div class="container">
		<div class="footer_content">
			<?php if ($temAgendamentos) { ?>
				<?php foreach ($agendamentos as $agendamento) {
					$id_agendamento = $agendamento['id_agendamento'] ?>
					<div class='agendamento' id='lista-agendamentos'>
						<p>Data: <?= date('d/m/Y', strtotime($agendamento['dia'])) ?></p>
						<p>Hora: <?= $agendamento['horario'] ?></p>
						<p>Funcionário: <?= $agendamento['nome_funcionario'] ?></p>
						<p>Serviço: <?= $agendamento['nome_servico'] ?> - R$
							<?= number_format($agendamento['valor_servico'], 2, ',', '.') ?>
						</p>
						<button onclick='editarAgendamento(<?= $id_agendamento ?>)'>Editar</button>
						<button onclick='excluirAgendamento(<?= $id_agendamento ?>)'>Excluir</button>
					</div>
				<?php }
			} ?>



			<form id="form-agenda" method="post"
				style="margin-top: -25px !important; <?= $temAgendamentos ? 'display: none;' : '' ?>">
				<div class="footer_form footer-col">
					<div class="form-group">
						<input oninput="buscarNome()" class="form-control" type="text" name="telefone" id="telefone"
							value='<?= $telefone ?>' placeholder="Seu Telefone DDD + número" required disabled />
					</div>
					<div class="form-group">
						<input onclick="buscarNome()" class="form-control" type="text" name="nome" id="nome"
							value="<?= $nome ?>" placeholder="Seu Nome" required disabled />
					</div>
					<div class="form-group">
						<input onchange="mudarFuncionario()" class="form-control" type="date" name="data" id="data"
							value="<?= date('Y-m-d') ?>" min="<?= date('Y-m-d') ?>" required />
					</div>
					<div class="form-group">
						<select class="form-control sel2" id="funcionario" name="funcionario" style="width:100%;"
							onchange="mudarFuncionario()" required>
							<option value=""><?= $texto_agendamento ?></option>
							<?php
							$query = $pdo->query("SELECT * FROM usuarios WHERE atendimento = 'Sim' AND barbearia_id = '$barbershop_id' ORDER BY id desc");
							$res = $query->fetchAll(PDO::FETCH_ASSOC);
							foreach ($res as $row) {
								echo '<option value="' . $row['id'] . '">' . $row['nome'] . '</option>';
							}
							?>
						</select>
					</div>
					<div class="form-group">
						<div id="listar-horarios"></div>
					</div>
					<div class="form-group">
						<select onchange="mudarServico()" class="form-control sel2" id="servico" name="servico"
							style="width:100%;" required>
							<option value="">Selecione um Serviço</option>
							<?php
							$query = $pdo->query("SELECT * FROM servicos WHERE barbearia_id = $barbershop_id ORDER BY nome asc");
							$res = $query->fetchAll(PDO::FETCH_ASSOC);
							foreach ($res as $row) {
								$valorF = number_format($row['valor'], 2, ',', '.');
								echo '<option value="' . $row['id'] . '">' . $row['nome'] . ' - R$ ' . $valorF . '</option>';
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
					<input type="text" id="data_oculta" style="display: none">
					<input type="hidden" id="hora_rec" nome="hora_rec">
					<input type="hidden" id="nome_func" nome="nome_func">
					<input type="hidden" id="data_rec" nome="data_rec">
					<input type="hidden" id="nome_serv" nome="nome_serv">
				</div>
			</form>
			<div id="listar-cartoes" style="margin-top: -30px"></div>
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
		$('.sel2').select2({});
	});

	function mudarFuncionario() {
		var funcionario = $('#funcionario').val();
		var data = $('#data').val();
		var hora = $('#hora_rec').val();
		listarHorarios(funcionario, data, hora);
		listarFuncionario();
	}

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

	function buscarNome(telefone) {
		// var tel = telefone;
		// listarCartoes(tel);

		// $.ajax({
		// 	url: "ajax/listar-nome.php",
		// 	method: 'POST',
		// 	data: { tel },
		// 	dataType: "text",
		// 	success: function (result) {
		// 		var split = result.split("*");
		// 		if (split[2] == "" || split[2] == undefined) {
		// 		} else {
		// 			$("#funcionario").val(parseInt(split[2])).change();
		// 		}
		// 		$("#nome").val(split[0]);
		// 		$("#data_oculta").val(split[1]);
		// 		$("#data").val($("#data_oculta").val());
		// 		$("#id").val(split[3]);
		// 		$("#hora_rec").val(split[4]);
		// 		$("#obs").val(split[6]);
		// 		$("#id_excluir").val(split[3]);
		// 		$("#nome_func").val(split[8]);
		// 		$("#data_rec").val(split[7]);
		// 		$("#nome_serv").val(split[9]);
		// 		$("#msg-excluir").text('Deseja Realmente excluir esse agendamento feito para o dia ' + split[7] + ' às ' + split[4]);
		// 		mudarFuncionario();
		// 	}
		// });
	}

	function editarAgendamento(id) {
		$.ajax({
			url: "ajax/carregar-agendamento.php",
			method: 'POST',
			data: { id },
			dataType: "json",
			success: function (data) {
				$("#id_agendamento").val(id);
				$("#nome").val(data.nome_cliente);
				$("#telefone").val(data.telefone_cliente);
				$("#data").val(data.data);
				$("#hora_rec").val(data.horario);
				$("#funcionario").val(data.funcionario).change();
				$("#servico").val(data.servico).change();
				$("#obs").val(data.obs);
				$("#form-agenda").show();
				$("#lista-agendamentos").hide();
				$("#botao_salvar").text('Atualizar Agendamento');
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

	function salvar() {
		$('#id').val('');
	}

	$("#form-agenda").submit(function (event) {
		event.preventDefault(); // Impede o envio padrão do formulário

		var formData = new FormData(this); // Cria um objeto FormData com os dados do formulário

		$.ajax({
			url: "ajax/agendar.php", // URL para onde os dados serão enviados
			type: 'POST', // Método HTTP usado
			data: formData, // Dados do formulário
			contentType: false, // Não definir contentType, pois o FormData cuida disso
			processData: false, // Não processar os dados, pois o FormData cuida disso
			cache: false, // Não armazenar em cache
			success: function (mensagem) {
				// Limpa a mensagem anterior e remove classes
				$('#mensagem').text('').removeClass();

				// Verifica se a mensagem de sucesso foi retornada
				if (mensagem.trim() === "Agendado com Sucesso" || mensagem.trim() === "Editado com Sucesso") {
					$('#mensagem').text(mensagem).addClass('sucesso'); // Exibe a mensagem de sucesso

					// Recarrega a página após 2 segundos
					setTimeout(() => {
						window.location.reload();
					}, 2000);
				} else {
					// Exibe a mensagem de erro
					$('#mensagem').text(mensagem).addClass('erro');
				}
			},
			error: function (xhr, status, error) {
				// Exibe uma mensagem de erro detalhada
				$('#mensagem').text(`Erro no envio: ${xhr.responseText || error}`).addClass('erro');
			}
		});
	});


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
					location.reload();
				} else {
					$('#mensagem-excluir').text(mensagem);
				}
			},
			cache: false,
			contentType: false,
			processData: false,
		});
	});



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