<?php
@session_start();
require_once("verificar.php");
require_once("../conexao.php");

$pag = 'funcionarios';
$id_funcionario = $_SESSION['id'];

// Dias da semana disponíveis
$dias_semana = ['Segunda-Feira', 'Terça-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'Sábado', 'Domingo'];

// Buscar dias já cadastrados para esse funcionário
$query = $pdo->query("SELECT dia FROM dias WHERE funcionario = $id_funcionario");
$dados = $query->fetchAll(PDO::FETCH_COLUMN);

// Remover os dias já cadastrados da lista
$dias_disponiveis = array_diff($dias_semana, $dados);
?>

<form id="form-dias">
    <div class="row">
        <div class="col-md-2">
            <div class="form-group">
                <label for="exampleInputEmail1">Dia</label>
                <select class="form-control" id="dias" name="dias" required>
                    <option value="">Selecione um dia</option>
                    <?php foreach ($dias_disponiveis as $dia): ?>
                        <option value="<?php echo $dia ?>"><?php echo $dia ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>

        <div class="col-md-4">
            <button type="submit" class="btn btn-primary" style="margin-top:20px">Salvar</button>
        </div>

        <input type="hidden" name="id" id="id_dias" value="<?php echo $id_usuario ?>">

    </div>
</form>

<small>
    <div id="mensagem-dias"></div>
</small>

<big>
    <div class="bs-example widget-shadow" style="padding:15px" id="listar-dias">

    </div>
</big>



<script type="text/javascript">
    var pag = "<?= $pag ?>";
</script>


<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        var func = $("#id_dias").val();
        listarDias(func)
    });
</script>



<script type="text/javascript">


    $("#form-dias").submit(function () {

        var func = $("#id_dias").val();
        event.preventDefault();
        var formData = new FormData(this);

        $.ajax({
            url: 'paginas/' + pag + "/inserir-dias.php",
            type: 'POST',
            data: formData,

            success: function (mensagem) {
                $('#mensagem-dias').text('');
                $('#mensagem-dias').removeClass()
                if (mensagem.trim() == "Salvo com Sucesso") {

                    //$('#btn-fechar-horarios').click();
                    listarDias(func);

                } else {

                    $('#mensagem-dias').addClass('text-danger')
                    $('#mensagem-dias').text(mensagem)
                }


            },

            cache: false,
            contentType: false,
            processData: false,

        });

    });


</script>


<script type="text/javascript">
    function listarDias(func) {

        $.ajax({
            url: 'paginas/' + pag + "/listar-dias.php",
            method: 'POST',
            data: { func },
            dataType: "html",

            success: function (result) {
                $("#listar-dias").html(result);
                $('#mensagem-dias-excluir').text('');
            }
        });
    }

</script>