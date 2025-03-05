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


<div class="footer_section" style="background: #5a8e94;">
    <div class="container">
        <div class="footer_content ">
            <form id="form-agenda" method="post" style="margin-top: -25px !important">
                <input type="tel" class="form-control" id="telefone" name="telefone" placeholder="Seu Telefone DDD + número" required>
                <input type="text" class="form-control" id="nome" name="nome" placeholder="Seu Nome" required>

            </form>




            <div id="listar-cartoes" style="margin-top: -30px">

            </div>


        </div>


    </div>


</div>




<?php require_once("rodape.php") ?>





?>