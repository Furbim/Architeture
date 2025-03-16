<?php require_once("sistema/conexao.php") ?>
<!-- footer section -->
<footer class="footer_section">
  <div class="container">
    <div class="footer_content ">
      <div class="row ">
        <div class="col-md-5 col-lg-5 footer-col">
          <div class="footer_detail">
            <a href="index.php">
              <h4>
                <?php echo $nome_sistema ?>
              </h4>
            </a>
            <p>
              <?php echo $texto_rodape ?>
            </p>
          </div>
        </div>
        <div class="col-md-7 col-lg-4 ">
          <h4>
            Contatos
          </h4>
          <div class="contact_nav footer-col">
            <a href="">
              <i class="fa fa-map-marker" aria-hidden="true"></i>
              <span>
                <?php echo $endereco_sistema ?>
              </span>
            </a>
            <a href="http://api.whatsapp.com/send?1=pt_BR&phone=<?php echo $tel_whatsapp ?>">
              <i class="fa fa-phone" aria-hidden="true"></i>
              <span>
                Whatsapp : <?php echo $whatsapp_sistema ?>
              </span>
            </a>
            <a href="">
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span>
                Email : <?php echo $email_sistema ?>
              </span>
            </a>
          </div>
        </div>
        <div class="col-lg-3">
          <div class="footer_form footer-col">
            <h4>
              CADASTRE-SE
            </h4>
            <form id="form_cadastro" method="post" action="entrar.php">
              <input type="text" name="telefone" id="telefone_rodape" placeholder="Seu Telefone DDD + número" />
              <input type="text" name="nome" placeholder="Seu Nome" />
              <button type="submit">
                Cadastrar
              </button>
            </form>
            <br><small>
              <div id="mensagem-rodape"></div>
            </small>
          </div>
        </div>
      </div>
    </div>
  </div>

</footer>
<!-- footer section -->

<!-- jQuery (Mantido para compatibilidade com máscaras e Owl Carousel) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Bootstrap JS (Inclui Popper.js) -->
<script src="js/bootstrap.js"></script>

<!-- Owl Carousel -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<!-- Máscaras JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>

<!-- Script Customizado -->
<script src="js/custom.js"></script>

<!-- Google Maps (Substitua a chave pela correta) -->
<script src="https://maps.googleapis.com/maps/api/js?key=SUA_CHAVE_AQUI&callback=myMap"></script>

</body>

</html>