-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 19/03/2025 às 08:21
-- Versão do servidor: 8.2.0
-- Versão do PHP: 8.2.13

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

DROP TABLE IF EXISTS `acessos`;
CREATE TABLE IF NOT EXISTS `acessos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `chave` varchar(50) NOT NULL,
  `grupo` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `agendamentos`;
CREATE TABLE IF NOT EXISTS `agendamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `funcionario` int NOT NULL,
  `cliente` int NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `obs` varchar(100) DEFAULT NULL,
  `data_lanc` date NOT NULL,
  `usuario` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `servico` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `funcionario`, `cliente`, `data`, `hora`, `obs`, `data_lanc`, `usuario`, `status`, `servico`) VALUES
(6, 0, 2, '2022-06-06', '00:00:00', '', '2022-06-06', 10, 'Agendado', 0),
(10, 11, 2, '2022-06-06', '08:00:00', '', '2022-06-06', 6, 'Concluído', 2),
(11, 11, 3, '2022-06-06', '08:30:00', '', '2022-06-06', 6, 'Concluído', 1),
(13, 10, 2, '2022-06-06', '08:00:00', '', '2022-06-06', 6, 'Concluído', 2),
(14, 10, 3, '2022-06-06', '09:00:00', '', '2022-06-06', 6, 'Concluído', 4),
(15, 11, 2, '2022-06-07', '08:00:00', '', '2022-06-06', 6, 'Agendado', 2),
(16, 11, 2, '2022-06-06', '09:00:00', '', '2022-06-06', 6, 'Concluído', 2),
(17, 10, 2, '2022-06-07', '08:00:00', '', '2022-06-06', 6, 'Agendado', 2),
(18, 6, 2, '2022-06-07', '08:00:00', '', '2022-06-06', 6, 'Concluído', 2),
(19, 6, 3, '2022-06-07', '09:00:00', '', '2022-06-06', 6, 'Concluído', 1),
(20, 10, 2, '2022-06-07', '10:00:00', '', '2022-06-06', 6, 'Agendado', 1),
(22, 11, 2, '2022-06-08', '08:00:00', '', '2022-06-08', 6, 'Agendado', 2),
(24, 11, 4, '2022-06-08', '09:00:00', '', '2022-06-08', 6, 'Agendado', 2),
(25, 10, 2, '2022-06-08', '11:00:00', '', '2022-06-08', 6, 'Agendado', 2),
(26, 10, 2, '2022-06-08', '13:00:00', '', '2022-06-08', 6, 'Agendado', 2),
(27, 6, 2, '2022-06-08', '08:00:00', '', '2022-06-08', 6, 'Concluído', 2),
(28, 6, 2, '2022-06-09', '10:00:00', '', '2022-06-08', 6, 'Concluído', 2),
(29, 6, 2, '2022-06-08', '12:00:00', '', '2022-06-08', 6, 'Concluído', 2),
(30, 6, 3, '2022-06-09', '11:00:00', '', '2022-06-09', 6, 'Concluído', 1),
(31, 6, 2, '2022-06-09', '12:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(33, 6, 2, '2022-06-09', '08:00:00', '', '2022-06-09', 6, 'Concluído', 5),
(34, 11, 2, '2022-06-09', '08:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(35, 10, 2, '2022-06-09', '10:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(36, 11, 2, '2022-06-09', '08:30:00', '', '2022-06-09', 6, 'Concluído', 2),
(37, 6, 2, '2022-06-10', '08:00:00', '', '2022-06-09', 6, 'Concluído', 5),
(38, 6, 2, '2022-06-08', '09:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(39, 10, 2, '2022-06-09', '11:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(40, 11, 3, '2022-06-09', '09:00:00', '', '2022-06-09', 6, 'Concluído', 1),
(41, 10, 2, '2022-06-09', '09:00:00', '', '2022-06-09', 6, 'Concluído', 2),
(42, 6, 4, '2022-06-10', '09:00:00', '', '2022-06-09', 6, 'Concluído', 4),
(44, 11, 4, '2022-06-09', '09:30:00', '', '2022-06-09', 6, 'Concluído', 4),
(45, 11, 2, '2022-06-10', '08:00:00', '', '2022-06-09', 6, 'Concluído', 5),
(46, 10, 2, '2022-06-09', '17:00:00', '', '2022-06-09', 6, 'Agendado', 2),
(47, 6, 4, '2022-06-09', '15:00:00', '', '2022-06-09', 6, 'Agendado', 5),
(49, 11, 4, '2022-06-09', '10:00:00', '', '2022-06-09', 6, 'Agendado', 5),
(50, 11, 3, '2022-06-13', '08:30:00', '', '2022-06-13', 6, 'Concluído', 5),
(51, 6, 2, '2022-06-13', '08:00:00', '', '2022-06-13', 6, 'Concluído', 2),
(52, 6, 3, '2022-06-13', '09:00:00', '', '2022-06-13', 6, 'Concluído', 2),
(53, 6, 4, '2022-06-13', '10:00:00', '', '2022-06-13', 6, 'Agendado', 1),
(54, 6, 2, '2022-06-15', '09:00:00', '', '2022-06-15', 6, 'Concluído', 2),
(55, 6, 3, '2022-06-15', '11:00:00', '', '2022-06-15', 6, 'Agendado', 2),
(56, 6, 2, '2022-06-15', '10:00:00', '', '2022-06-15', 6, 'Concluído', 2),
(57, 6, 2, '2022-06-15', '08:00:00', '', '2022-06-15', 6, 'Concluído', 1),
(58, 10, 3, '2022-06-15', '08:00:00', '', '2022-06-15', 6, 'Concluído', 2),
(59, 10, 3, '2022-06-15', '09:00:00', '', '2022-06-15', 6, 'Concluído', 5),
(60, 10, 3, '2022-06-15', '11:00:00', '', '2022-06-15', 6, 'Concluído', 4),
(61, 10, 2, '2022-06-15', '12:00:00', '', '2022-06-15', 6, 'Agendado', 2),
(62, 10, 3, '2022-06-15', '14:00:00', '', '2022-06-15', 6, 'Concluído', 2),
(63, 10, 3, '2022-06-15', '15:00:00', '', '2022-06-15', 6, 'Agendado', 5),
(64, 6, 2, '2022-06-15', '15:00:00', '', '2022-06-15', 6, 'Concluído', 2),
(69, 6, 12, '2022-06-27', '08:00:00', '', '2022-06-27', 0, 'Agendado', 1),
(71, 11, 10, '2022-06-27', '09:30:00', '', '2022-06-27', 0, 'Agendado', 10),
(72, 6, 10, '2022-06-28', '15:00:00', 'sss', '2022-06-27', 0, 'Agendado', 10),
(79, 11, 13, '2022-06-28', '09:30:00', '', '2022-06-27', 0, 'Agendado', 1),
(80, 6, 10, '2022-06-28', '11:00:00', 'sss', '2022-06-27', 0, 'Agendado', 10),
(81, 6, 10, '2022-06-28', '16:00:00', '', '2022-06-27', 0, 'Agendado', 5),
(108, 10, 11, '2022-06-27', '14:00:00', '', '2022-06-27', 0, 'Agendado', 5),
(114, 6, 15, '2025-03-04', '16:00:00', '', '2025-03-03', 0, 'Agendado', 10),
(115, 6, 21, '2025-03-05', '15:00:00', '', '2025-03-04', 0, 'Agendado', 2),
(116, 10, 22, '2025-03-04', '13:00:00', '', '2025-03-04', 0, 'Agendado', 2),
(122, 6, 1, '2025-03-19', '17:00:00', '', '2025-03-19', 0, 'Agendado', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `assinaturas`
--

DROP TABLE IF EXISTS `assinaturas`;
CREATE TABLE IF NOT EXISTS `assinaturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `barbearia_id` int NOT NULL,
  `plano_id` int NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`),
  KEY `plano_id` (`plano_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `barbearias`
--

DROP TABLE IF EXISTS `barbearias`;
CREATE TABLE IF NOT EXISTS `barbearias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `data_cadastro` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `barbearias`
--

INSERT INTO `barbearias` (`id`, `nome`, `endereco`, `telefone`, `email`, `data_cadastro`) VALUES
(1, 'Barbearia Elite', 'Rua das Acácias, 123', '31987654321', 'elite@email.com', '2025-03-09'),
(2, 'Barbearia Estilo', 'Av. Principal, 456', '31999998888', 'contato@estilo.com', '2025-03-09'),
(3, 'Barbearia Luxo', NULL, '31988887777', 'luxo@email.com', '2025-03-09');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargos`
--

DROP TABLE IF EXISTS `cargos`;
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `cat_produtos`;
CREATE TABLE IF NOT EXISTS `cat_produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `cat_servicos`;
CREATE TABLE IF NOT EXISTS `cat_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `data_nasc` date NOT NULL,
  `data_cad` date NOT NULL,
  `cartoes` int NOT NULL,
  `data_retorno` date DEFAULT NULL,
  `ultimo_servico` int NOT NULL,
  `alertado` varchar(5) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `telefone`, `endereco`, `data_nasc`, `data_cad`, `cartoes`, `data_retorno`, `ultimo_servico`, `alertado`, `email`, `senha`) VALUES
(1, 'Thiago Martins De Freitas', '(31) 98311-4021', NULL, '0000-00-00', '2025-03-05', 0, NULL, 0, 'Não', 'thiagofreitasofc202@gmail.com', '$2y$10$wuqcDI9qzCCUus99vulA9usng.OA6Jj3xTr9y8cn51lDbwbydBvWK'),
(2, 'Thiago Martins De Freitas', '(31) 98311-4022', NULL, '0000-00-00', '2025-03-05', 0, NULL, 0, 'Não', 'thiagofreitasofc22@gmail.com', '$2y$10$Ygyz8gdCt9a3ECdGVrHmcuc2kGGpwki.okYQMPrreusJVxGwdOrkO');

-- --------------------------------------------------------

--
-- Estrutura para tabela `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `texto` varchar(500) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `ativo` varchar(5) NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `img_banner_index` varchar(100) DEFAULT NULL,
  `texto_sobre` varchar(600) DEFAULT NULL,
  `imagem_sobre` varchar(100) DEFAULT NULL,
  `icone_site` varchar(100) NOT NULL,
  `mapa` varchar(1000) DEFAULT NULL,
  `texto_fidelidade` varchar(255) DEFAULT NULL,
  `quantidade_cartoes` int NOT NULL,
  `texto_agendamento` varchar(30) DEFAULT NULL,
  `msg_agendamento` varchar(5) DEFAULT NULL,
  `barbearia_id` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `config`
--

INSERT INTO `config` (`id`, `nome`, `email`, `telefone_fixo`, `telefone_whatsapp`, `endereco`, `logo`, `icone`, `logo_rel`, `tipo_rel`, `instagram`, `tipo_comissao`, `texto_rodape`, `img_banner_index`, `texto_sobre`, `imagem_sobre`, `icone_site`, `mapa`, `texto_fidelidade`, `quantidade_cartoes`, `texto_agendamento`, `msg_agendamento`, `barbearia_id`) VALUES
(2, 'Barbearia Teste', 'teste@teste.com', '(31) 9831-1402', '(31) 99999-999', 'Rua Francisco Duarte Mendonça, 2239', 'logo.png', 'favicon.png', 'logo_rel.jpg', 'HTML', '', 'R$', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', 'Barbearia especializada em tudo', 'getlstd-property-photo.jpg', 'favicon.png', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d278.6662693600645!2d-44.00935398939279!3d-19.997117902149707!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xa6bd0017bcaf21%3A0x4837d8503fa8319b!2sThiago%20Freitas%20Barbearia!5e0!3m2!1spt-BR!2sbr!4v1741552894891!5m2!1spt-BR!2sbr\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>', '', 0, 'Selecionar Prestador de Serviç', 'Sim', 1),
(5, '', '', NULL, '', NULL, 'logo.png', 'favicon.ico', 'logo_rel.jpg', 'pdf', NULL, 'Porcentagem', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', NULL, NULL, '', NULL, NULL, 10, 'Selecionar Prestador de Serviç', 'Sim', 2),
(6, '', '', NULL, '', NULL, 'logo.png', 'favicon.ico', 'logo_rel.jpg', 'pdf', NULL, 'Porcentagem', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', NULL, NULL, '', NULL, NULL, 10, 'Selecionar Prestador de Serviç', 'Sim', 4),
(7, '', '', NULL, '', NULL, 'logo.png', 'favicon.ico', 'logo_rel.jpg', 'pdf', NULL, 'Porcentagem', 'Edite este texto nas configurações do painel administrador', 'hero-bg.jpg', NULL, NULL, '', NULL, NULL, 10, 'Selecionar Prestador de Serviç', 'Sim', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `dias`
--

DROP TABLE IF EXISTS `dias`;
CREATE TABLE IF NOT EXISTS `dias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia` varchar(25) NOT NULL,
  `funcionario` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

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
(18, 'Segunda-Feira', 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `entradas`
--

DROP TABLE IF EXISTS `entradas`;
CREATE TABLE IF NOT EXISTS `entradas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int NOT NULL,
  `data` date NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `entradas`
--

INSERT INTO `entradas` (`id`, `produto`, `quantidade`, `motivo`, `usuario`, `data`, `barbearia_id`) VALUES
(1, 2, 8, 'Encontrados', 6, '2022-05-31', 1),
(3, 2, 2, 'Encontrados', 6, '2022-05-31', 1),
(4, 10, 8, 'Devolução', 6, '2022-06-14', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `data_cad` date NOT NULL,
  `tipo_chave` varchar(25) DEFAULT NULL,
  `chave_pix` varchar(50) DEFAULT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `fornecedores`
--

INSERT INTO `fornecedores` (`id`, `nome`, `telefone`, `endereco`, `data_cad`, `tipo_chave`, `chave_pix`, `barbearia_id`) VALUES
(1, 'Fornecedor 2', '(55) 55555-5555', 'Rua Guajajaras 140 Centro', '2022-05-31', 'Email', 'fornecedor2@hotmail.com', 1),
(2, 'Fornecedor 1', '(88) 88888-8888', 'Teste', '2022-05-31', 'CPF', '123111111', 1),
(4, 'Fornecedor 3', '(31) 78999-9999', 'Rua C', '2022-06-13', 'CNPJ', '11.111.111/1111-11', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `grupo_acessos`
--

DROP TABLE IF EXISTS `grupo_acessos`;
CREATE TABLE IF NOT EXISTS `grupo_acessos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

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
(8, 'Dados Site');

-- --------------------------------------------------------

--
-- Estrutura para tabela `horarios`
--

DROP TABLE IF EXISTS `horarios`;
CREATE TABLE IF NOT EXISTS `horarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horario` time NOT NULL,
  `funcionario` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

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
(10, '08:00:00', 6),
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
(29, '07:00:00', 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagar`
--

DROP TABLE IF EXISTS `pagar`;
CREATE TABLE IF NOT EXISTS `pagar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  `tipo` varchar(35) DEFAULT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data_lanc` date NOT NULL,
  `data_venc` date NOT NULL,
  `data_pgto` date NOT NULL,
  `usuario_lanc` int NOT NULL,
  `usuario_baixa` int NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `pessoa` int NOT NULL,
  `pago` varchar(5) NOT NULL,
  `produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `funcionario` int NOT NULL,
  `servico` int NOT NULL,
  `cliente` int NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb3;

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
(78, 'Comissão - Barba', 'Comissão', 8.50, '2022-06-27', '2022-06-27', '0000-00-00', 6, 0, 'sem-foto.jpg', 0, 'Não', 0, 0, 11, 2, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `planos_assinatura`
--

DROP TABLE IF EXISTS `planos_assinatura`;
CREATE TABLE IF NOT EXISTS `planos_assinatura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `categoria` int NOT NULL,
  `valor_compra` decimal(8,2) NOT NULL,
  `valor_venda` decimal(8,2) NOT NULL,
  `estoque` int NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `nivel_estoque` int NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `categoria`, `valor_compra`, `valor_venda`, `estoque`, `foto`, `nivel_estoque`, `barbearia_id`) VALUES
(1, 'Pomada para Barbas', 'Pomada para barbas...', 1, 24.00, 60.00, 12, '14-06-2022-16-44-05-BARBA-04.png', 5, 1),
(2, 'Creme Hidratação', 'Creme para hidratar...', 2, 2.00, 35.00, 41, '14-06-2022-16-43-42-creme-hidrataçao.png', 5, 1),
(4, 'Loção Pós Barba', 'Loção para barba creme X', 5, 10.00, 15.00, 48, '14-06-2022-16-43-17-BARBA-03.png', 5, 1),
(5, 'Pomada Modeladora', 'Pomada Modeladora para Cabelos', 1, 10.00, 10.00, 8, '14-06-2022-16-42-47-BARBA-06.png', 5, 1),
(6, 'Creme para Barbas', 'Evita a pele ficar hirritada...', 2, 31.25, 35.00, 8, '14-06-2022-16-44-44-BARBA-05.png', 5, 1),
(7, 'Pomada Gel Modeladora', 'Pomada que tem uma ação de gel que mantém seu cabelo modelado mais tempo', 1, 10.00, 30.00, 60, '14-06-2022-17-30-52-pomada.png', 5, 1),
(10, 'Creme Pele', 'Creme ...', 2, 0.00, 35.00, 8, '14-06-2022-16-52-39-p2.png', 10, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `receber`
--

DROP TABLE IF EXISTS `receber`;
CREATE TABLE IF NOT EXISTS `receber` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  `tipo` varchar(35) DEFAULT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data_lanc` date NOT NULL,
  `data_venc` date NOT NULL,
  `data_pgto` date NOT NULL,
  `usuario_lanc` int NOT NULL,
  `usuario_baixa` int NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `pessoa` int NOT NULL,
  `pago` varchar(5) NOT NULL,
  `produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `servico` int NOT NULL,
  `funcionario` int NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  `id_agendamento` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`),
  KEY `id_agendamento` (`id_agendamento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `receber`
--

INSERT INTO `receber` (`id`, `descricao`, `tipo`, `valor`, `data_lanc`, `data_venc`, `data_pgto`, `usuario_lanc`, `usuario_baixa`, `foto`, `pessoa`, `pago`, `produto`, `quantidade`, `servico`, `funcionario`, `barbearia_id`, `id_agendamento`) VALUES
(2, 'Corte + Barba', 'Serviço', 45.00, '2025-03-19', '2025-03-19', '2025-03-18', 6, 6, 'sem-foto.jpg', 1, 'Não', 0, 0, 10, 6, 1, 122);

-- --------------------------------------------------------

--
-- Estrutura para tabela `saidas`
--

DROP TABLE IF EXISTS `saidas`;
CREATE TABLE IF NOT EXISTS `saidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

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

DROP TABLE IF EXISTS `servicos`;
CREATE TABLE IF NOT EXISTS `servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `categoria` int NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `dias_retorno` int NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `comissao` decimal(8,2) NOT NULL,
  `barbearia_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`id`, `nome`, `categoria`, `valor`, `foto`, `dias_retorno`, `ativo`, `comissao`, `barbearia_id`) VALUES
(1, 'Corte', 1, 25.00, '14-06-2022-15-40-01-CORTE-01.png', 15, 'Sim', 10.00, 1),
(2, 'Barba', 1, 17.00, '14-06-2022-15-39-39-BARBA-01.png', 7, 'Sim', 8.50, 1),
(4, 'Luzes', 2, 35.00, '14-06-2022-15-39-29-BARBA-02.png', 20, 'Sim', 8.00, 1),
(5, 'Hidrataçao', 2, 40.00, '14-06-2022-15-39-20-hidratacao.png', 180, 'Sim', 5.00, 1),
(8, 'Mão e Pé', 5, 50.00, '14-06-2022-15-39-09-unha.png', 15, 'Sim', 10.00, 1),
(9, 'Unha de Gel', 5, 150.00, '14-06-2022-15-38-59-unha-de-gel.png', 30, 'Sim', 10.00, 1),
(10, 'Corte + Barba', 1, 45.00, '14-06-2022-15-40-40-CORTE-E-BARBA.png', 15, 'Sim', 15.00, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `textos_index`
--

DROP TABLE IF EXISTS `textos_index`;
CREATE TABLE IF NOT EXISTS `textos_index` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(25) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `barbearia_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `textos_index`
--

INSERT INTO `textos_index` (`id`, `titulo`, `descricao`, `barbearia_id`) VALUES
(1, 'Cortes Profissionais', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(2, 'Faça sua Barba', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(3, 'Mega Hair', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1),
(4, 'Unha de Gel', 'Descrição relacionado ao texto, você poderá alterar essa descrição e o título do texto acima no painel administrativo, lá terá uma opção para gerenciar os recursos do site.', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `barbearia_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barbearia_id` (`barbearia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `cpf`, `senha`, `senha_crip`, `nivel`, `data`, `ativo`, `telefone`, `endereco`, `foto`, `atendimento`, `tipo_chave`, `chave_pix`, `barbearia_id`) VALUES
(6, 'Admin', 'admin@admin', '000.000.000-00', '123', '202cb962ac59075b964b07152d234b70', 'Administrador', '2022-05-25', 'Sim', '(31) 99999-9999', 'Rua xxx, 8 ', '18-07-2024-17-31-03-Logo.png', 'Sim', NULL, NULL, 1),
(8, 'Recepcionista Teste', 'recep@hotmail.com', '555.555.555-55', '123', '202cb962ac59075b964b07152d234b70', 'Recepcionista', '2022-05-30', 'Sim', '(44) 44444-4444', 'Rua C', '30-05-2022-13-19-34-08-03-2022-22-21-20-02-03-2022-09-59-04-Arthur.jpg', 'Não', NULL, NULL, NULL),
(9, 'Gerente', 'gerente@hotmail.com', '444.444.444-46', '123', '202cb962ac59075b964b07152d234b70', 'Gerente', '2022-05-30', 'Sim', '(22) 12121-2121', 'Rua C', 'sem-foto.jpg', 'Não', NULL, NULL, NULL),
(10, 'Barbeiro', 'barbeiro@hotmail.com', '555.555.555-58', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-05-30', 'Sim', '(48) 54545-5555', 'Rua X', 'sem-foto.jpg', 'Sim', NULL, NULL, NULL),
(11, 'Barbeiro 2', 'barbeiro2@hotmail.com', '545.454.545-45', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-05-30', 'Sim', '(85) 54545-454', 'Rua C', 'sem-foto.jpg', 'Sim', 'CPF', '545.454.545-45', NULL),
(12, 'Cabelereira Teste', 'cabelereira@hotmail.com', '000.000.000-11', '123', '202cb962ac59075b964b07152d234b70', 'Cabelereira', '2022-06-06', 'Sim', '(25) 88888-8888', 'Rua X', 'sem-foto.jpg', 'Sim', 'CPF', '111.111.111-17', 1),
(13, 'Manicure', 'manicure@hotmail.com', '111.111.111-01', '123', '202cb962ac59075b964b07152d234b70', 'Manicure e Pedicure', '2022-06-06', 'Sim', '(11) 11111-1111', 'Rua C', 'sem-foto.jpg', 'Sim', 'Telefone', '3198888-8888', 1),
(14, 'Barbeiro 3', 'barbeiro3@hotmail.com', '888.888.888-81', '123', '202cb962ac59075b964b07152d234b70', 'Barbeiro', '2022-06-13', 'Sim', '(47) 77777-7777', 'Rua C', 'sem-foto.jpg', 'Sim', 'CPF', '111.111.111-12', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios_permissoes`
--

DROP TABLE IF EXISTS `usuarios_permissoes`;
CREATE TABLE IF NOT EXISTS `usuarios_permissoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` int NOT NULL,
  `permissao` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb3;

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
  ADD CONSTRAINT `id_agendamento` FOREIGN KEY (`id_agendamento`) REFERENCES `agendamentos` (`id`),
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
