-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/05/2025 às 20:51
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `barbearia`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `acessos`
--

CREATE TABLE `acessos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `chave` varchar(50) NOT NULL,
  `grupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `acessos`
--

INSERT INTO `acessos` (`id`, `nome`, `chave`, `grupo`) VALUES
(1, 'Usuários', 'usuarios', 1),
(2, 'Funcionários', 'funcionarios', 1),
(3, 'Clientes', 'clientes', 1),
(4, 'Clientes Retornos', 'clientes_retorno', 1),
(5, 'Fornecedores', 'fornecedores', 1),
(6, 'Serviços', 'servicos', 2),
(7, 'Cargos', 'cargos', 2),
(8, 'Categoria Serviços', 'cat_servicos', 2),
(9, 'Grupo Acessos', 'grupos', 2),
(10, 'Acessos', 'acessos', 2),
(11, 'Produtos', 'produtos', 3),
(12, 'Categorias', 'cat_produtos', 3),
(13, 'Estoque Baixo', 'estoque', 3),
(14, 'Saídas', 'saidas', 3),
(15, 'Entradas', 'entradas', 3),
(16, 'Vendas', 'vendas', 4),
(17, 'Compras', 'compras', 4),
(18, 'Contas à Pagar', 'pagar', 4),
(19, 'Contas à Receber', 'receber', 4),
(20, 'Agendamentos', 'agendamentos', 5),
(21, 'Serviços Agendamentos', 'servicos_agenda', 5),
(22, 'Home', 'home', 0),
(25, 'Relatório Produtos', 'rel_produtos', 7),
(26, 'Relatório de Entradas', 'rel_entradas', 7),
(27, 'Relatório de Saídas', 'rel_saidas', 7),
(28, 'Relatório de Comissões', 'rel_comissoes', 7),
(29, 'Relatório de Contas', 'rel_contas', 7),
(30, 'Aniversáriantes', 'rel_aniv', 7),
(31, 'Relatório de Lucro', 'rel_lucro', 7),
(32, 'Textos Banner Index', 'textos_index', 8),
(33, 'Comentários / Depoimentos', 'comentarios', 8),
(34, 'Configurações do Sistema', 'configuracoes', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `funcionario` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `obs` varchar(100) DEFAULT NULL,
  `data_lanc` date NOT NULL,
  `usuario` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `servico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `funcionario`, `cliente`, `data`, `hora`, `obs`, `data_lanc`, `usuario`, `status`, `servico`) VALUES
(25, 6, 1, '2025-03-31', '08:00:00', '', '2025-03-29', 6, 'Concluído', 10),
(26, 6, 1, '2025-05-06', '08:00:00', 'adsads', '2025-05-05', 0, 'Concluído', 10),
(27, 6, 4, '2025-05-06', '16:00:00', '', '2025-05-05', 0, 'Concluído', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `assinaturas`
--

CREATE TABLE `assinaturas` (
  `id` int(11) NOT NULL,
  `barbearia_id` int(11) NOT NULL,
  `plano_id` int(11) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `barbearias`
--

CREATE TABLE `barbearias` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  `numero` int(11) NOT NULL,
  `cep` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `barbearias`
--

INSERT INTO `barbearias` (`id`, `nome`, `endereco`, `telefone`, `email`, `data_cadastro`, `numero`, `cep`) VALUES
(1, 'Barbearia Elite', 'Rua das Acácias', '31987654321', 'elite@email.com', '2025-03-09', 123, '30642310'),
(2, 'Barbearia Estilo', 'Av. Principal', '31999998888', 'contato@estilo.com', '2025-03-09', 456, '30642325'),
(3, 'Barbearia Luxo', 'Rua Francisco Duarte de Mendonça', '31988887777', 'luxo@email.com', '2025-03-09', 2239, '30987242');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargos`
--

CREATE TABLE `cargos` (
  `id` int(11) NOT NULL,
  `nome` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `cargos`
--

INSERT INTO `cargos` (`id`, `nome`) VALUES
(9, 'Administrador'),
(10, 'Gerente'),
(11, 'Recepcionista'),
(12, 'Barbeiro'),
(13, 'Cabelereira');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cat_produtos`
--

CREATE TABLE `cat_produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `cat_produtos`
--

INSERT INTO `cat_produtos` (`id`, `nome`, `barbearia_id`) VALUES
(1, 'Pomadas', 1),
(2, 'Cremes', 1),
(3, 'Lâminas e Giletes', 1),
(4, 'Bebidas', 1),
(5, 'Gel', 1),
(7, 'Esmaltes', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cat_servicos`
--

CREATE TABLE `cat_servicos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `cat_servicos`
--

INSERT INTO `cat_servicos` (`id`, `nome`, `barbearia_id`) VALUES
(1, 'Corte', 1),
(2, 'Química', 1),
(5, 'Manicure e Pedicure', 2),
(6, 'Depilação', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `data_nasc` date NOT NULL,
  `data_cad` date NOT NULL,
  `cartoes` int(11) NOT NULL,
  `data_retorno` date DEFAULT NULL,
  `ultimo_servico` int(11) NOT NULL,
  `alertado` varchar(5) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `telefone`, `endereco`, `data_nasc`, `data_cad`, `cartoes`, `data_retorno`, `ultimo_servico`, `alertado`, `email`, `senha`) VALUES
(1, 'Thiago Martins De Freitas', '(31) 98311-4021', NULL, '0000-00-00', '2025-03-05', 1, '2025-05-04', 10, 'Sim', 'thiagofreitasofc202@gmail.com', '$2y$10$wuqcDI9qzCCUus99vulA9usng.OA6Jj3xTr9y8cn51lDbwbydBvWK'),
(2, 'Thiago Martins De Freitas', '(31) 98311-4022', NULL, '0000-00-00', '2025-03-05', 0, NULL, 0, 'Não', 'thiagofreitasofc22@gmail.com', '$2y$10$Ygyz8gdCt9a3ECdGVrHmcuc2kGGpwki.okYQMPrreusJVxGwdOrkO'),
(3, '', '', NULL, '0000-00-00', '0000-00-00', 0, NULL, 0, NULL, '', ''),
(4, 'Thiago Martins De Freitas', '31983114022', NULL, '0000-00-00', '2025-05-05', 0, '2025-05-21', 10, 'Não', 'thigamer0074@gmail.com', '$2y$10$vfD4.SPWDEkETPdJh.AZ0O4EBJZpDbGAxg5PKK50ZpsXOdos0hAx6');

-- --------------------------------------------------------

--
-- Estrutura para tabela `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `texto` varchar(500) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `ativo` varchar(5) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `comentarios`
--

INSERT INTO `comentarios` (`id`, `nome`, `texto`, `foto`, `ativo`, `barbearia_id`) VALUES
(2, 'Paulo Campos', 'Aqui será o texto do comentário referente a essa mensagem e poderá ser aprovado ou não pelo administrador do site. Aqui será o texto do comentário referente a essa mensagem e poderá ser aprovado ou não pelo administrador do site.', '14-06-2022-19-10-25-c1.jpg', 'Sim', 1),
(3, 'Marcos Silva', 'Aqui será o texto do comentário referente a essa mensagem e poderá ser aprovado ou não pelo administrador do site.', '14-06-2022-19-11-32-30-05-2022-13-19-34-08-03-2022-22-21-20-02-03-2022-09-59-04-Arthur.jpg', 'Sim', 1),
(4, 'Marcos Santos', 'Aqui será o texto do comentário referente a essa mensagem e poderá ser aprovado ou não pelo administrador do site.', '14-06-2022-19-11-50-c2.jpg', 'Sim', 1),
(15, 'Fabricio Campos', 'Excelente barbearia, sempre bom atendimento, preços assecíveis, Excelente barbearia, sempre bom atendimento, preços assecíveis, Excelente barbearia, sempre bom atendimento, preços assecíveis, ', '14-06-2022-20-10-40-c1.jpg', 'Sim', 1),
(16, 'Marcelo Silva', 'Excelente barbearia, sempre bom atendimento, preços assecíveis, Excelente barbearia, sempre bom atendimento, preços assecíveis, Excelente barbearia, sempre bom atendimento, preços assecíveis, ', '14-06-2022-20-13-02-c2.jpg', 'Sim', 1),
(18, 'Priscila Matos', 'Excelente Salão de cabereira, muito bom atendimento.', '14-06-2022-20-17-37-favicon.png', 'Não', 1),
(21, 'Thiago', ' sjdiofhsjdfhslkjdfhlkajshdldjahlfkds', '12-03-2025-11-47-08-user.png', 'Sim', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefone_fixo` varchar(20) DEFAULT NULL,
  `telefone_whatsapp` varchar(20) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `icone` varchar(100) DEFAULT NULL,
  `logo_rel` varchar(100) DEFAULT NULL,
  `tipo_rel` varchar(10) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `tipo_comissao` varchar(25) NOT NULL,
  `texto_rodape` varchar(255) DEFAULT NULL,
  `img_banner_index` varchar(100) DEFAULT 'hero-bg.jpg',
  `texto_sobre` varchar(600) DEFAULT NULL,
  `imagem_sobre` varchar(100) NOT NULL DEFAULT 'getlstd-property-photo.jpg',
  `icone_site` varchar(100) NOT NULL,
  `mapa` varchar(1000) DEFAULT NULL,
  `texto_fidelidade` varchar(255) DEFAULT NULL,
  `quantidade_cartoes` int(11) NOT NULL,
  `texto_agendamento` varchar(30) DEFAULT NULL,
  `msg_agendamento` varchar(5) DEFAULT NULL,
  `barbearia_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `config`
--

INSERT INTO `config` (`id`, `nome`, `email`, `telefone_fixo`, `telefone_whatsapp`, `endereco`, `logo`, `icone`, `logo_rel`, `tipo_rel`, `instagram`, `tipo_comissao`, `texto_rodape`, `img_banner_index`, `texto_sobre`, `imagem_sobre`, `icone_site`, `mapa`, `texto_fidelidade`, `quantidade_cartoes`, `texto_agendamento`, `msg_agendamento`, `barbearia_id`) VALUES
(2, 'OnBarber', 'teste@teste.com', '(31) 9831-1402', '(31) 99999-999', 'Rua Francisco Duarte Mendonça, 2239', 'logo.png', 'favicon.png', 'logo_rel.jpg', 'HTML', NULL, 'R$', 'Edite este texto nas configurações do painel administrador', 'Captura-de-tela-2025-02-22-104211.png', 'Barbearia especializada em tudo', 'getlstd-property-photo.jpg', 'favicon.png', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d278.6662693600645!2d-44.00935398939279!3d-19.997117902149707!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xa6bd0017bcaf21%3A0x4837d8503fa8319b!2sThiago%20Freitas%20Barbearia!5e0!3m2!1spt-BR!2sbr!4v1741552894891!5m2!1spt-BR!2sbr\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '', 0, 'Selecionar Prestador de Serviç', 'Sim', 1),
(5, 'Heroes', '', NULL, '', NULL, 'logo.png', 'favicon.ico', 'logo_rel.jpg', 'pdf', NULL, 'Porcentagem', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', NULL, 'getlstd-property-photo.jpg', '', NULL, NULL, 10, 'Selecionar Prestador de Serviç', 'Sim', 2),
(7, 'Batman', '', NULL, '', NULL, 'logo.png', 'favicon.ico', 'logo_rel.jpg', 'pdf', NULL, 'Porcentagem', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', NULL, 'getlstd-property-photo.jpg', '', NULL, NULL, 10, 'Selecionar Prestador de Serviç', 'Sim', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `dias`
--

CREATE TABLE `dias` (
  `id` int(11) NOT NULL,
  `dia` varchar(25) NOT NULL,
  `funcionario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `dias`
--

INSERT INTO `dias` (`id`, `dia`, `funcionario`) VALUES
(1, 'Segunda-Feira', 11),
(2, 'Terça-Feira', 11),
(3, 'Quarta-Feira', 11),
(4, 'Quinta-Feira', 11),
(5, 'Sexta-Feira', 11),
(6, 'Sábado', 11),
(8, 'Terça-Feira', 10),
(9, 'Quarta-Feira', 10),
(10, 'Quinta-Feira', 10),
(11, 'Sexta-Feira', 10),
(12, 'Terça-Feira', 6),
(13, 'Quarta-Feira', 6),
(14, 'Quinta-Feira', 6),
(15, 'Sexta-Feira', 6),
(16, 'Sábado', 6),
(17, 'Segunda-Feira', 10),
(18, 'Segunda-Feira', 6),
(19, 'Segunda-Feira', 14),
(20, 'Terça-Feira', 14),
(21, 'Quarta-Feira', 14),
(22, 'Quinta-Feira', 14),
(23, 'Sexta-Feira', 14),
(24, 'Domingo', 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `entradas`
--

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` date NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `entradas`
--

INSERT INTO `entradas` (`id`, `produto`, `quantidade`, `motivo`, `usuario`, `data`, `barbearia_id`) VALUES
(1, 2, 8, 'Encontrados', 6, '2022-05-31', 1),
(3, 2, 2, 'Encontrados', 6, '2022-05-31', 1),
(4, 10, 8, 'Devolução', 6, '2022-06-14', 1),
(5, 11, 100, 'sank,fanjsk', 6, '2025-05-06', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedores`
--

CREATE TABLE `fornecedores` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `data_cad` date NOT NULL,
  `tipo_chave` varchar(25) DEFAULT NULL,
  `chave_pix` varchar(50) DEFAULT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `fornecedores`
--

INSERT INTO `fornecedores` (`id`, `nome`, `telefone`, `endereco`, `data_cad`, `tipo_chave`, `chave_pix`, `barbearia_id`) VALUES
(2, 'Fornecedor 1', '(88) 88888-8888', 'Teste', '2022-05-31', 'CPF', '123111111', 1),
(4, 'Fornecedor 3', '(31) 78999-9999', 'Rua C', '2022-06-13', 'CNPJ', '11.111.111/1111-11', 1),
(5, 'Thiago Martins De Freitas', '(31) 98311-4021', 'Rua Francisco Duarte Mendonça, 2239', '2025-05-06', 'CPF', '12677298643', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `grupo_acessos`
--

CREATE TABLE `grupo_acessos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `grupo_acessos`
--

INSERT INTO `grupo_acessos` (`id`, `nome`) VALUES
(1, 'Pessoas'),
(2, 'Cadastros'),
(3, 'Produtos'),
(4, 'Financeiro'),
(5, 'Agendamento / Serviços'),
(7, 'Relatórios'),
(8, 'Dados Site'),
(10, 'agendamentos');

-- --------------------------------------------------------

--
-- Estrutura para tabela `horarios`
--

CREATE TABLE `horarios` (
  `id` int(11) NOT NULL,
  `horario` time NOT NULL,
  `funcionario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `horarios`
--

INSERT INTO `horarios` (`id`, `horario`, `funcionario`) VALUES
(1, '08:00:00', 10),
(2, '09:00:00', 10),
(4, '12:00:00', 10),
(5, '10:00:00', 10),
(6, '13:00:00', 10),
(7, '11:00:00', 10),
(8, '08:00:00', 9),
(9, '09:00:00', 9),
(11, '09:00:00', 6),
(12, '10:00:00', 6),
(14, '08:00:00', 11),
(15, '08:30:00', 11),
(16, '09:00:00', 11),
(17, '09:30:00', 11),
(18, '14:00:00', 10),
(19, '15:00:00', 10),
(20, '16:00:00', 10),
(21, '17:00:00', 10),
(22, '11:00:00', 6),
(23, '12:00:00', 6),
(24, '15:00:00', 6),
(25, '16:00:00', 6),
(26, '17:00:00', 6),
(27, '10:00:00', 11),
(28, '12:00:00', 11),
(29, '07:30:00', 14),
(31, '08:30:00', 14),
(32, '09:30:00', 14),
(33, '10:30:00', 14),
(34, '11:30:00', 14),
(35, '12:30:00', 14),
(36, '13:30:00', 14),
(37, '15:30:00', 14),
(38, '16:30:00', 14),
(39, '17:30:00', 14),
(41, '08:00:00', 6),
(42, '09:30:00', 6),
(43, '10:30:00', 6),
(44, '11:30:00', 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagar`
--

CREATE TABLE `pagar` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `tipo` varchar(35) DEFAULT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data_lanc` date NOT NULL,
  `data_venc` date NOT NULL,
  `data_pgto` date NOT NULL,
  `usuario_lanc` int(11) NOT NULL,
  `usuario_baixa` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `pessoa` int(11) NOT NULL,
  `pago` varchar(5) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `funcionario` int(11) NOT NULL,
  `servico` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `pagar`
--

INSERT INTO `pagar` (`id`, `descricao`, `tipo`, `valor`, `data_lanc`, `data_venc`, `data_pgto`, `usuario_lanc`, `usuario_baixa`, `foto`, `pessoa`, `pago`, `produto`, `quantidade`, `funcionario`, `servico`, `cliente`, `barbearia_id`) VALUES
(1, 'Conta de Luz', 'Conta', 870.00, '2022-05-31', '2022-05-31', '0000-00-00', 6, 0, '31-05-2022-14-29-55-09-11-2021-09-21-26-conta3.jpg', 0, 'Não', 0, 0, 0, 0, 0, 1),
(2, 'Conta de Água', 'Conta', 750.00, '2022-05-31', '2022-05-31', '0000-00-00', 6, 0, '31-05-2022-14-30-08-09-11-2021-10-17-10-pdfteste.pdf', 0, 'Não', 0, 0, 0, 0, 0, 1),
(4, 'Compra de Cadeiras', 'Conta', 750.00, '2022-05-31', '2022-05-31', '2022-04-30', 6, 6, 'sem-foto.jpg', 1, 'Sim', 0, 0, 0, 0, 0, 1),
(5, 'Conta Vencida', 'Conta', 50.00, '2022-05-31', '2022-05-30', '2022-05-31', 6, 6, '31-05-2022-14-53-15-09-11-2021-12-04-29-pdfteste.zip', 1, 'Sim', 0, 0, 0, 0, 0, 1),
(6, 'aaaaaa', 'Conta', 45.00, '2022-05-31', '2022-05-31', '2022-05-31', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 0, 0, 0, 1),
(9, 'Compra - (10) Creme Cabelo', 'Compra', 150.00, '2022-05-31', '2022-05-31', '2022-05-31', 6, 6, 'sem-foto.jpg', 2, 'Sim', 2, 10, 0, 0, 0, 1),
(11, 'Compra - (5) Pomada Cabelo XXX', 'Compra', 185.00, '2022-05-31', '2022-05-31', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 1, 5, 0, 0, 0, 1),
(14, 'Vencida', 'Conta', 88.00, '2022-05-31', '2022-05-30', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 0, 0, 0, 1),
(17, 'Compra - (2) Creme Cabelo', 'Compra', 50.00, '2022-05-31', '2022-05-30', '2022-05-31', 6, 6, 'sem-foto.jpg', 2, 'Sim', 2, 2, 0, 0, 0, 1),
(18, 'Compra - (30) Creme Cabelo', 'Compra', 500.00, '2022-05-31', '2022-05-31', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 2, 30, 0, 0, 0, 1),
(19, 'Compra - (25) Pomada Cabelo XXX', 'Compra', 600.00, '2022-05-31', '2022-05-31', '0000-00-00', 6, 0, 'sem-foto.jpg', 1, 'Não', 1, 25, 0, 0, 0, 1),
(20, 'Conta de Telefone', 'Conta', 380.00, '2022-05-31', '2022-06-02', '0000-00-00', 6, 0, '31-05-2022-19-50-37-09-11-2021-12-04-29-pdfteste.zip', 0, 'Não', 0, 0, 0, 0, 0, 1),
(21, 'Compra - (40) Gel', 'Compra', 400.00, '2022-05-31', '2022-05-31', '2022-05-31', 6, 6, 'sem-foto.jpg', 1, 'Sim', 4, 40, 0, 0, 0, 1),
(22, 'Comissão :Barba', 'Comissão', 1.45, '2022-06-09', '2022-06-09', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 2, 0, 1),
(25, 'Comissão - Luzes', 'Comissão', 8.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 4, 0, 1),
(27, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 2, 0, 1),
(28, 'Comissão - Hidrataçao', 'Comissão', 5.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 5, 0, 1),
(29, 'Comissão - Hidrataçao', 'Comissão', 5.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 5, 0, 1),
(30, 'Comissão - Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 11, 2, 0, 1),
(31, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 11, 2, 0, 1),
(32, 'Comissão - Hidrataçao', 'Comissão', 5.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 5, 0, 1),
(33, 'Comissão - Luzes', 'Comissão', 8.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 4, 0, 1),
(34, 'Comissão - Unha de Gel', 'Comissão', 10.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 9, 0, 1),
(35, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 2, 0, 1),
(36, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 2, 0, 1),
(37, 'Comissão - Mão e Pé', 'Comissão', 10.00, '2022-06-09', '2022-06-09', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 12, 8, 0, 1),
(38, 'Comissão - Corte', 'Comissão', 10.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 11, 1, 3, 1),
(39, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 2, 2, 1),
(40, 'Comissão - Luzes', 'Comissão', 8.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 4, 4, 1),
(41, 'Comissão - Hidrataçao', 'Comissão', 5.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 5, 1, 1),
(42, 'Comissão - Luzes', 'Comissão', 8.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 11, 4, 4, 1),
(43, 'Comissão - Hidrataçao', 'Comissão', 5.00, '2022-06-09', '2022-06-09', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 5, 2, 1),
(44, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 2, 2, 1),
(45, 'Comissão - Mão e Pé', 'Comissão', 10.00, '2022-06-09', '2022-06-09', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 12, 8, 2, 1),
(46, 'Aluguél', 'Conta', 950.00, '2022-06-09', '2022-06-09', '2022-06-09', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 0, 0, 0, 1),
(47, 'Compra de Pomadas', 'Conta', 360.00, '2022-06-13', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 1, 'Não', 0, 0, 0, 0, 0, 1),
(48, 'Comissão - Hidrataçao', 'Comissão', 2.00, '2022-06-13', '2022-06-13', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 11, 5, 3, 1),
(49, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-13', '2022-06-13', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(50, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-13', '2022-06-13', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 2, 3, 1),
(51, 'Conta de Luz', 'Conta', 800.00, '2022-06-13', '2022-06-13', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 0, 0, 0, 1),
(52, 'Compra - (6) Creme Cabelo', 'Compra', 60.00, '2022-06-13', '2022-06-13', '2022-06-13', 6, 6, 'sem-foto.jpg', 0, 'Sim', 2, 6, 0, 0, 0, 1),
(53, 'Compra de Giletes', 'Conta', 50.00, '2022-06-13', '2022-06-13', '2022-06-13', 6, 6, 'sem-foto.jpg', 2, 'Sim', 0, 0, 0, 0, 0, 1),
(54, 'Compra - (5) Creme Hidratação', 'Compra', 10.00, '2022-06-14', '2022-06-14', '2022-06-14', 6, 6, 'sem-foto.jpg', 2, 'Sim', 2, 5, 0, 0, 0, 1),
(55, 'Compra - (8) Creme para Barbas', 'Compra', 250.00, '2022-06-14', '2022-06-14', '2022-06-15', 6, 6, 'sem-foto.jpg', 0, 'Sim', 6, 8, 0, 0, 0, 1),
(56, 'Compra - (6) Esmalte Longa Duração', 'Compra', 60.00, '2022-06-14', '2022-06-14', '2022-06-14', 6, 6, 'sem-foto.jpg', 4, 'Sim', 9, 6, 0, 0, 0, 1),
(57, 'Compra - (9) Esmalte Risqué', 'Compra', 90.00, '2022-06-14', '2022-06-14', '0000-00-00', 6, 0, 'sem-foto.jpg', 2, 'Não', 8, 9, 0, 0, 0, 1),
(58, 'Compra - (12) Loção Pós Barba', 'Compra', 120.00, '2022-06-14', '2022-06-14', '0000-00-00', 6, 0, 'sem-foto.jpg', 4, 'Não', 4, 12, 0, 0, 0, 1),
(59, 'Compra - (10) Esmalte Longa Duração', 'Compra', 100.00, '2022-06-14', '2022-06-14', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 9, 10, 0, 0, 0, 1),
(60, 'Compra - (10) Esmalte Risqué', 'Compra', 100.00, '2022-06-14', '2022-06-14', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 8, 10, 0, 0, 0, 1),
(61, 'Compra - (60) Pomada Gel Modeladora', 'Compra', 600.00, '2022-06-14', '2022-06-14', '2022-06-14', 6, 6, 'sem-foto.jpg', 4, 'Sim', 7, 60, 0, 0, 0, 1),
(62, 'Compra - (8) Pomada Modeladora', 'Compra', 80.00, '2022-06-14', '2022-06-14', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 5, 8, 0, 0, 0, 1),
(63, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(64, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(65, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(66, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(67, 'Comissão - Corte', 'Comissão', 2.50, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 1, 2, 1),
(68, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 2, 3, 1),
(69, 'Comissão - Hidrataçao', 'Comissão', 2.00, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 5, 3, 1),
(70, 'Comissão - Luzes', 'Comissão', 2.80, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 4, 3, 1),
(71, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 10, 2, 3, 1),
(72, 'Comissão - Hidrataçao', 'Comissão', 2.00, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 5, 2, 1),
(73, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 2, 2, 1),
(74, 'Comissão - Luzes', 'Comissão', 2.80, '2022-06-15', '2022-06-15', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 4, 2, 1),
(75, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-27', '2022-06-27', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 2, 2, 1),
(76, 'Comissão - Barba', 'Comissão', 1.45, '2022-06-27', '2022-06-27', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 2, 2, 1),
(77, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-27', '2022-06-27', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 2, 2, 1),
(78, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-27', '2022-06-27', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 2, 2, 1),
(81, 'Conta', 'Conta', 100.00, '2025-03-15', '2025-03-13', '2025-03-14', 6, 6, 'sem-foto.jpg', 1, 'Sim', 0, 0, 9, 0, 0, 1),
(82, 'Conta', 'Conta', 100.00, '2025-03-29', '2025-03-29', '2025-03-28', 6, 6, 'sem-foto.jpg', 2, 'Sim', 0, 0, 6, 0, 0, 1),
(83, 'Conta de luz', 'Conta', 250.00, '2025-03-29', '2025-03-29', '2025-03-28', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 0, 0, 1),
(84, 'Comissão - Corte + Barba', 'Comissão', 15.00, '2025-03-29', '2025-03-29', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 6, 10, 1, 1),
(86, 'Comissão - Corte + Barba', 'Comissão', 15.00, '2025-05-06', '2025-05-06', '2025-05-06', 6, 6, 'sem-foto.jpg', 0, 'Sim', 0, 0, 6, 10, 4, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `planos_assinatura`
--

CREATE TABLE `planos_assinatura` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `valor` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `planos_assinatura`
--

INSERT INTO `planos_assinatura` (`id`, `nome`, `valor`) VALUES
(1, 'Basic', 39.99),
(2, 'Pro', 59.99),
(3, 'Enterprise', 79.99);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `categoria` int(11) NOT NULL,
  `valor_compra` decimal(8,2) NOT NULL,
  `valor_venda` decimal(8,2) NOT NULL,
  `estoque` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `nivel_estoque` int(11) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `categoria`, `valor_compra`, `valor_venda`, `estoque`, `foto`, `nivel_estoque`, `barbearia_id`) VALUES
(1, 'Pomada para Barbas', 'Pomada para barbas...', 1, 24.00, 60.00, 12, '14-06-2022-16-44-05-BARBA-04.png', 5, 1),
(2, 'Creme Hidratação', 'Creme para hidratar...', 2, 2.00, 35.00, 41, '14-06-2022-16-43-42-creme-hidrataçao.png', 5, 1),
(4, 'Loção Pós Barba', 'Loção para barba creme X', 5, 10.00, 15.00, 36, '14-06-2022-16-43-17-BARBA-03.png', 5, 1),
(5, 'Pomada Modeladora', 'Pomada Modeladora para Cabelos', 1, 10.00, 10.00, 8, '14-06-2022-16-42-47-BARBA-06.png', 5, 1),
(6, 'Creme para Barbas', 'Evita a pele ficar hirritada...', 2, 31.25, 35.00, 8, '14-06-2022-16-44-44-BARBA-05.png', 5, 1),
(7, 'Pomada Gel Modeladora', 'Pomada que tem uma ação de gel que mantém seu cabelo modelado mais tempo', 1, 10.00, 30.00, 60, '14-06-2022-17-30-52-pomada.png', 5, 1),
(10, 'Creme Pele', 'Creme ...', 2, 20.00, 35.00, 8, '14-06-2022-16-52-39-p2.png', 10, 1),
(11, 'Pomada', 'asfhkajshçfkljas', 1, 45.00, 76.00, 100, '05-05-2025-23-52-26-Imagem-do-WhatsApp-de-2025-05-01-à(s)-12.51.47_1f8e903a.jpg', 10, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `receber`
--

CREATE TABLE `receber` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `tipo` varchar(35) DEFAULT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data_lanc` date NOT NULL,
  `data_venc` date NOT NULL,
  `data_pgto` date NOT NULL,
  `usuario_lanc` int(11) NOT NULL,
  `usuario_baixa` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `pessoa` int(11) NOT NULL,
  `pago` varchar(5) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `servico` int(11) NOT NULL,
  `funcionario` int(11) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1,
  `id_agendamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `receber`
--

INSERT INTO `receber` (`id`, `descricao`, `tipo`, `valor`, `data_lanc`, `data_venc`, `data_pgto`, `usuario_lanc`, `usuario_baixa`, `foto`, `pessoa`, `pago`, `produto`, `quantidade`, `servico`, `funcionario`, `barbearia_id`, `id_agendamento`) VALUES
(9, 'Corte + Barba', 'Serviço', 45.00, '2025-03-17', '2025-03-17', '2025-03-17', 6, 6, 'sem-foto.jpg', 3, 'Sim', 0, 0, 10, 6, 1, 11),
(11, 'Corte + Barba', 'Serviço', 45.00, '2025-03-17', '2025-03-18', '2025-03-18', 6, 6, 'sem-foto.jpg', 3, 'Sim', 0, 0, 10, 6, 1, 13),
(12, 'Barba', 'Serviço', 17.00, '2025-03-17', '2025-03-17', '2025-03-17', 6, 6, 'sem-foto.jpg', 3, 'Sim', 0, 0, 2, 6, 1, 14),
(13, 'Corte + Barba', 'Serviço', 45.00, '2025-03-17', '2025-03-17', '2025-03-17', 6, 6, 'sem-foto.jpg', 3, 'Sim', 0, 0, 10, 6, 1, 15),
(14, 'Corte + Barba', 'Serviço', 45.00, '2025-03-18', '2025-03-18', '2025-03-18', 6, 6, 'sem-foto.jpg', 3, 'Sim', 0, 0, 10, 6, 1, 16),
(23, 'Corte + Barba', 'Serviço', 45.00, '2025-03-29', '2025-03-29', '2025-03-29', 6, 6, 'sem-foto.jpg', 1, 'Sim', 0, 0, 10, 6, 1, NULL),
(24, 'Corte + Barba', 'Serviço', 45.00, '2025-05-05', '2025-05-05', '2025-05-05', 6, 6, 'sem-foto.jpg', 1, 'Sim', 0, 0, 10, 6, 1, 26),
(25, 'Corte + Barba', 'Serviço', 45.00, '2025-05-06', '2025-05-06', '2025-05-06', 6, 6, 'sem-foto.jpg', 4, 'Sim', 0, 0, 10, 6, 1, NULL),
(26, 'Descrição relacionado ao texto, você poderá altera', 'Conta', 180.00, '2025-05-06', '2025-05-06', '2025-05-06', 6, 6, 'sem-foto.jpg', 1, 'Sim', 0, 0, 0, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `saidas`
--

CREATE TABLE `saidas` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `saidas`
--

INSERT INTO `saidas` (`id`, `produto`, `quantidade`, `motivo`, `usuario`, `data`) VALUES
(1, 1, 2, 'Sumiço', 6, '2022-05-31'),
(2, 1, 1, 'Furto', 6, '2022-05-31'),
(3, 2, 2, 'Roubo', 6, '2022-05-31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `categoria` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `dias_retorno` int(11) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `comissao` decimal(8,2) NOT NULL,
  `barbearia_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`id`, `nome`, `categoria`, `valor`, `foto`, `dias_retorno`, `ativo`, `comissao`, `barbearia_id`) VALUES
(1, 'Corte', 1, 25.00, '1/14-06-2022-15-40-01-CORTE-01.png', 15, 'Sim', 10.00, 1),
(2, 'Barba', 1, 17.00, '1/14-06-2022-15-39-39-BARBA-01.png', 7, 'Sim', 8.50, 1),
(4, 'Luzes', 2, 35.00, '1/14-06-2022-15-39-29-BARBA-02.png', 20, 'Sim', 8.00, 1),
(5, 'Hidrataçao', 2, 40.00, '1/14-06-2022-15-39-20-hidratacao.png', 180, 'Sim', 5.00, 1),
(8, 'Mão e Pé', 5, 50.00, '1/14-06-2022-15-39-09-unha.png', 15, 'Sim', 10.00, 1),
(9, 'Unha de Gel', 5, 150.00, '1/14-06-2022-15-38-59-unha-de-gel.png', 30, 'Sim', 10.00, 1),
(10, 'Corte + Barba', 1, 45.00, '1/14-06-2022-15-40-40-CORTE-E-BARBA.png', 15, 'Sim', 15.00, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `textos_index`
--

CREATE TABLE `textos_index` (
  `id` int(11) NOT NULL,
  `titulo` varchar(25) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `barbearia_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `textos_index`
--

INSERT INTO `textos_index` (`id`, `titulo`, `descricao`, `barbearia_id`) VALUES
(1, 'Cortes Profissionais', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(2, 'Faça sua Barba', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(3, 'Mega Hair', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(4, 'Depilação', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `senha` varchar(25) NOT NULL,
  `senha_crip` varchar(100) NOT NULL,
  `nivel` varchar(35) NOT NULL,
  `data` date NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `atendimento` varchar(5) NOT NULL,
  `tipo_chave` varchar(25) DEFAULT NULL,
  `chave_pix` varchar(50) DEFAULT NULL,
  `barbearia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `cpf`, `senha`, `senha_crip`, `nivel`, `data`, `ativo`, `telefone`, `endereco`, `foto`, `atendimento`, `tipo_chave`, `chave_pix`, `barbearia_id`) VALUES
(6, 'Admin', 'admin@admin', '000.000.000-00', '123', '202cb962ac59075b964b07152d234b70', 'Administrador', '2022-05-25', 'Sim', '(31) 99999-9999', 'Rua xxx, 8 ', '1/18-07-2024-17-31-03-Logo.png', 'Sim', NULL, NULL, 1),
(8, 'Recepcionista Teste', 'recep@hotmail.com', '555.555.555-55', '123', '202cb962ac59075b964b07152d234b70', 'Recepcionista', '2022-05-30', 'Sim', '(44) 44444-4444', 'Rua C', '1/30-05-2022-13-19-34-08-03-2022-22-21-20-02-03-2022-09-59-04-Arthur.jpg', 'Não', NULL, NULL, 1),
(9, 'Gerente', 'gerente@hotmail.com', '444.444.444-46', '123', '202cb962ac59075b964b07152d234b70', 'Gerente', '2022-05-30', 'Sim', '(22) 12121-2121', 'Rua C', 'sem-foto.jpg', 'Não', NULL, NULL, 1),
(10, 'Barbeiro', 'barbeiro@hotmail.com', '555.555.555-58', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-05-30', 'Sim', '(48) 54545-5555', 'Rua X', 'sem-foto.jpg', 'Sim', NULL, NULL, 1),
(11, 'Barbeiro 2', 'barbeiro2@hotmail.com', '545.454.545-45', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-05-30', 'Sim', '(85) 54545-454', 'Rua C', 'sem-foto.jpg', 'Sim', 'CPF', '545.454.545-45', 1),
(12, 'Cabelereira Teste', 'cabelereira@hotmail.com', '000.000.000-11', '123', '202cb962ac59075b964b07152d234b70', 'Cabelereira', '2022-06-06', 'Sim', '(25) 88888-8888', 'Rua X', 'sem-foto.jpg', 'Sim', 'CPF', '111.111.111-17', 1),
(13, 'Manicure', 'manicure@hotmail.com', '111.111.111-01', '123', '202cb962ac59075b964b07152d234b70', 'Manicure e Pedicure', '2022-06-06', 'Sim', '(11) 11111-1111', 'Rua C', 'sem-foto.jpg', 'Sim', 'Telefone', '3198888-8888', 1),
(14, 'Barbeiro 3', 'barbeiro3@hotmail.com', '888.888.888-81', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-06-13', 'Sim', '(47) 77777-7777', 'Rua C', '1/06-05-2025-15-45-41-14-06-2022-15-40-01-CORTE-01.png', 'Sim', 'CPF', '111.111.111-12', 1),
(15, 'Thiago Martins De Freitas', 'mineirorf@uol.com.br', '126.772.986-43', '123', '202cb962ac59075b964b07152d234b70', 'Administrador', '2025-05-05', 'Sim', '31983114021', 'Rua Francisco Duarte Mendonça, 2239', 'sem-foto.jpg', 'Sim', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios_permissoes`
--

CREATE TABLE `usuarios_permissoes` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `permissao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `usuarios_permissoes`
--

INSERT INTO `usuarios_permissoes` (`id`, `usuario`, `permissao`) VALUES
(93, 13, 3),
(101, 13, 11),
(102, 13, 12),
(114, 9, 2),
(115, 9, 3),
(116, 9, 4),
(117, 9, 5),
(118, 9, 6),
(119, 9, 7),
(120, 9, 8),
(123, 9, 11),
(124, 9, 12),
(125, 9, 13),
(126, 9, 14),
(127, 9, 15),
(128, 9, 16),
(129, 9, 17),
(130, 9, 18),
(131, 9, 19),
(132, 9, 20),
(133, 9, 21),
(134, 9, 22),
(201, 10, 1),
(202, 10, 22),
(209, 11, 11),
(210, 11, 12),
(277, 8, 2),
(278, 8, 7),
(279, 8, 12),
(280, 8, 13),
(281, 8, 20),
(282, 11, 6),
(283, 11, 7),
(284, 8, 30),
(285, 8, 34),
(286, 8, 32);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `acessos`
--
ALTER TABLE `acessos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `assinaturas`
--
ALTER TABLE `assinaturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`),
  ADD KEY `plano_id` (`plano_id`);

--
-- Índices de tabela `barbearias`
--
ALTER TABLE `barbearias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `cat_produtos`
--
ALTER TABLE `cat_produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `cat_servicos`
--
ALTER TABLE `cat_servicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `dias`
--
ALTER TABLE `dias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `grupo_acessos`
--
ALTER TABLE `grupo_acessos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pagar`
--
ALTER TABLE `pagar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `planos_assinatura`
--
ALTER TABLE `planos_assinatura`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `receber`
--
ALTER TABLE `receber`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `saidas`
--
ALTER TABLE `saidas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `textos_index`
--
ALTER TABLE `textos_index`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barbearia_id` (`barbearia_id`);

--
-- Índices de tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `acessos`
--
ALTER TABLE `acessos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `assinaturas`
--
ALTER TABLE `assinaturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `barbearias`
--
ALTER TABLE `barbearias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `cat_produtos`
--
ALTER TABLE `cat_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `cat_servicos`
--
ALTER TABLE `cat_servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `dias`
--
ALTER TABLE `dias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `grupo_acessos`
--
ALTER TABLE `grupo_acessos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `pagar`
--
ALTER TABLE `pagar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de tabela `planos_assinatura`
--
ALTER TABLE `planos_assinatura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `receber`
--
ALTER TABLE `receber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `saidas`
--
ALTER TABLE `saidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `textos_index`
--
ALTER TABLE `textos_index`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=287;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `assinaturas`
--
ALTER TABLE `assinaturas`
  ADD CONSTRAINT `assinaturas_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`),
  ADD CONSTRAINT `assinaturas_ibfk_2` FOREIGN KEY (`plano_id`) REFERENCES `planos_assinatura` (`id`);

--
-- Restrições para tabelas `cat_produtos`
--
ALTER TABLE `cat_produtos`
  ADD CONSTRAINT `cat_produtos_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `cat_servicos`
--
ALTER TABLE `cat_servicos`
  ADD CONSTRAINT `cat_servicos_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD CONSTRAINT `fornecedores_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `pagar`
--
ALTER TABLE `pagar`
  ADD CONSTRAINT `pagar_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `receber`
--
ALTER TABLE `receber`
  ADD CONSTRAINT `receber_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `servicos`
--
ALTER TABLE `servicos`
  ADD CONSTRAINT `barbearia_id` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`),
  ADD CONSTRAINT `servicos_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `textos_index`
--
ALTER TABLE `textos_index`
  ADD CONSTRAINT `textos_index_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);

--
-- Restrições para tabelas `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`barbearia_id`) REFERENCES `barbearias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
