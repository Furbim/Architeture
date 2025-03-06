//Author: Monie Corleone
//Purpose: To draw line chart in canvas element
//The MIT License (MIT)
//Copyright (c) <2015> <Monie Corleone>
; (function ($, window, document, undefined) {
    var pluginName = "SimpleChart";

    var defaults = {
        ChartType: "Line", // Tipo de gráfico padrão. Pode ser: "Area", "Scattered", "Bar", "Hybrid", "Pie", "Stacked", "StackedHybrid"
        xPadding: 75, // Espaçamento horizontal entre a legenda do gráfico e os valores do eixo Y
        yPadding: 55, // Espaçamento vertical entre a legenda do gráfico e os valores do eixo X
        topmargin: 25, // Margem superior do gráfico
        rightmargin: 20, // Margem direita do gráfico
        
        // Configuração de dados
        data: null,

        // Configuração da ferramenta de tooltip
        toolwidth: 300,
        toolheight: 300,

        // Estilos visuais
        axiscolor: "#333",
        font: "Satoshi, sans-serif",
        headerfontsize: "14px",
        axisfontsize: "12px",
        piefontsize: "13px",
        textcolor: "#E6E6E6",

        // Cores do gráfico de pizza
        pielabelcolor: "#fff",
        pielabelpercentcolor: "#000",
        pieborderColor: "#fff",
        pieborderWidth: 2,

        // Configuração do alinhamento e legendas
        textAlign: "center",
        showlegends: true,
        showpielables: false,
        legendposition: "bottom",
        legendsize: "100",
        LegendTitle: "Legend",

        // Rótulos do eixo
        xaxislabel: null,
        yaxislabel: null,
        title: null
    };


    // Função construtora do plugin SimpleChart
function Plugin(element, options) {
    // Armazena o elemento onde o gráfico será renderizado
    this.element = element;
    // Mescla as opções padrão com as opções fornecidas
    this.options = $.extend({}, defaults, options);
    // Inicializa o plugin
    this.init();
}

// Definição dos métodos do protótipo do Plugin
Plugin.prototype = {
    // Método de inicialização: configura o canvas e chama as funções de desenho
    init: function () {
        var that = this,
            config = that.options;
        // Adiciona classes e cria um elemento canvas para o gráfico
        var graph = $(that.element)
            .addClass("SimpleChart")
            .addClass(config.ChartType)
            .append("<canvas class='SimpleChartcanvas'></canvas>")
            .find('canvas')
            .css({
                // Define o alinhamento do canvas conforme a posição da legenda
                float: (config.legendposition == 'right' || config.legendposition == 'left') ? 'left' : '',
                'margin-top': config.topmargin,
                'margin-right': config.rightmargin
            });
        // Obtém o contexto 2D do canvas
        var ctx = graph[0].getContext("2d");
        // Define a largura do canvas, ajustando para legendas e margens
        graph[0].width = $(that.element).width() - (config.showlegends ? ((config.legendposition == 'right' || config.legendposition == 'left') ? parseInt(config.legendsize) + parseInt(config.xPadding) : 0) : 0) - config.rightmargin;
        // Define a altura do canvas, ajustando para legendas e margens
        graph[0].height = $(that.element).height() - (config.showlegends ? ((config.legendposition == 'bottom' || config.legendposition == 'top') ? config.legendsize : 0) : 0) - config.topmargin;
        // Obtém novamente o contexto 2D (caso necessário)
        var c = graph[0].getContext('2d');

        // Seleciona o método de desenho baseado no tipo de gráfico
        switch (config.ChartType) {
            case "Line":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawLineAreaScatteredHybridCharts(c, graph); // Desenha o gráfico de linhas
                break;
            case "Area":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawLineAreaScatteredHybridCharts(c, graph); // Desenha o gráfico de área
                break;
            case "Scattered":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawLineAreaScatteredHybridCharts(c, graph); // Desenha o gráfico disperso
                break;
            case "Hybrid":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawLineAreaScatteredHybridCharts(c, graph); // Desenha as linhas e áreas
                that.drawBar(c, graph); // Desenha as barras
                that.drawHybrid(c, graph); // Desenha elementos híbridos adicionais
                break;
            case "Bar":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawBar(c, graph); // Desenha o gráfico de barras
                break;
            case "Pie":
                that.drawPie(c, graph); // Desenha o gráfico de pizza
                break;
            case "Stacked":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawStacked(c, graph); // Desenha o gráfico empilhado
                break;
            case "StackedHybrid":
                that.drawAxis(c, graph); // Desenha os eixos
                that.drawStacked(c, graph); // Desenha o gráfico empilhado
                that.drawLineAreaScatteredHybridCharts(c, graph); // Desenha as linhas/áreas adicionais
                break;
        }

        // Se a legenda estiver habilitada, desenha a legenda
        if (config.showlegends) {
            that.drawLegends(graph);
        }
    },

    // Recarrega o gráfico, reinicializando o plugin
    reload: function () {
        $(this.element).empty();
        this.init();
    },

    // Destroi o gráfico, removendo seu conteúdo
    destroy: function () {
        $(this.element).empty();
    },

    // Calcula o valor máximo de Y nos dados e ajusta para o próximo múltiplo de 10
    FindYMax: function () {
        config = this.options;
        var max = 0;
        for (var i = 0; i < config.data.length; i++) {
            for (var j = 0; j < config.data[i].values.length; j++) {
                if (config.data[i].values[j].Y > max) {
                    max = config.data[i].values[j].Y;
                }
            }
        }
        max += 10 - max % 10;
        return max;
    },

    // Calcula a posição X de um ponto no gráfico
    pixelX: function (val, i) {
        config = this.options;
        var graph = $(this.element).find('.SimpleChartcanvas');
        return ((graph.width() - config.xPadding) / config.data[i].values.length) * val + (config.xPadding * 1.5);
    },

    // Calcula a posição Y de um ponto no gráfico
    pixelY: function (val) {
        config = this.options;
        var graph = $(this.element).find('.SimpleChartcanvas');
        return graph.height() - (((graph.height() - config.yPadding) / this.FindYMax()) * val) - config.yPadding;
    },

    // Gera uma cor aleatória no formato hexadecimal
    getRandomColor: function () {
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    },

    // Desenha os eixos X e Y do gráfico
    drawAxis: function (c, graph) {
        var that = this,
            xelementarray = new Array(),
            config = this.options;
        // Configura os parâmetros visuais dos eixos
        c.lineWidth = 2;
        c.strokeStyle = config.axiscolor;
        c.font = config.font;
        c.textAlign = config.textAlign;

        // Desenha o contorno dos eixos
        c.beginPath();
        c.moveTo(config.xPadding, 0);
        c.lineTo(config.xPadding, graph.height() - config.yPadding);
        c.lineTo(graph.width(), graph.height() - config.yPadding);
        c.stroke();

        // Define a cor do texto para os rótulos
        c.fillStyle = config.textcolor;

        // Percorre os dados e desenha os rótulos do eixo X, evitando duplicatas
        for (var i = 0; i < config.data.length; i++) {
            for (var j = 0; j < config.data[i].values.length; j++) {
                if (xelementarray.indexOf(config.data[i].values[j].X) < 0) {
                    xelementarray.push(config.data[i].values[j].X);
                    c.fillText(config.data[i].values[j].X, that.pixelX(j, i), graph.height() - config.yPadding + 20);
                }
            }
        }
        c.save();
        // Ajusta a fonte para os rótulos dos eixos
        var fontArgs = c.font.split(' ');
        c.font = config.axisfontsize + ' ' + fontArgs[fontArgs.length - 1];

        // Desenha o rótulo do eixo X, se definido
        if (config.xaxislabel) {
            c.fillText(config.xaxislabel, graph.width() / 2, graph.height());
        }
        // Desenha o rótulo do eixo Y, se definido, com rotação
        if (config.yaxislabel) {
            c.save();
            c.translate(0, graph.height() / 2);
            c.rotate(-Math.PI / 2);
            c.fillText(config.yaxislabel, 0, 15);
            c.restore();
        }
        // Adiciona o título ao gráfico, se definido
        if (config.title) {
            $("<div class='simple-chart-Header' />")
                .appendTo($(that.element))
                .html(config.title)
                .css({
                    left: graph.width() / 2 - ($(that.element).find('.simple-chart-Header').width() / 2),
                    top: 5
                });
        }
        c.restore();

        // Desenha as marcas e valores do eixo Y
        c.textAlign = "right";
        c.textBaseline = "middle";
        var maxY = that.FindYMax();
        var incrementvalue = "";
        for (var i = 0; i < Math.ceil(maxY).toString().length - 1; i++) {
            incrementvalue += "0";
        }
        incrementvalue = "1" + incrementvalue;
        incrementvalue = Math.ceil(maxY / parseInt(incrementvalue)) * Math.pow(10, (Math.ceil(maxY / 10).toString().length - 1));
        for (var i = 0; i < that.FindYMax(); i += parseInt(incrementvalue)) {
            c.fillStyle = config.textcolor;
            c.fillText(i, config.xPadding - 10, that.pixelY(i));
            c.fillStyle = config.axiscolor;
            c.beginPath();
            c.arc(config.xPadding, that.pixelY(i), 6, 0, Math.PI * 2, true);
            c.fill();
        }
    },

    // Desenha o gráfico de pizza
    drawPie: function (c, graph) {
        var that = this,
            config = this.options;
        // Limpa a área do canvas
        c.clearRect(0, 0, graph.width(), graph.height());
        var totalVal = 0, lastend = 0;
        // Calcula o valor total dos dados
        for (var j = 0; j < config.data[0].values.length; j++) {
            totalVal += (typeof config.data[0].values[j].Y == 'number') ? config.data[0].values[j].Y : 0;
        }

        // Desenha cada fatia da pizza
        for (var i = 0; i < config.data[0].values.length; i++) {
            c.fillStyle = config.data[0].linecolor == "Random" ?
                config.data[0].values[i].color = randomcolor = that.getRandomColor() :
                config.data[0].linecolor;
            c.beginPath();
            var centerx = graph.width() / 2.2;
            var centery = graph.height() / 2.2;
            c.moveTo(centerx, centery);
            c.arc(centerx, centery,
                (config.legendposition == 'right' || config.legendposition == 'left') ? centerx : centery,
                lastend,
                lastend + (Math.PI * 2 * (config.data[0].values[i].Y / totalVal)),
                false);
            c.lineTo(centerx, centery);
            c.fill();
            // Desenha o contorno da fatia
            c.fillStyle = config.pielabelcolor;
            c.lineWidth = config.pieborderWidth;
            c.strokeStyle = config.pieborderColor;
            c.stroke();

            // Se habilitado, desenha os rótulos de cada fatia
            if (config.showpielables) {
                c.save();
                c.translate(centerx, centery);
                c.rotate(lastend - 0.20 + (Math.PI * 2 * (config.data[0].values[i].Y / totalVal)));
                var dx = Math.floor(centerx * 0.5) + 40;
                var dy = Math.floor(centery * 0.05);
                c.textAlign = "right";
                var fontArgs = c.font.split(' ');
                c.font = config.piefontsize + ' ' + fontArgs[fontArgs.length - 1];
                c.fillText(config.data[0].values[i].X, dx, dy);
                c.restore();

                c.save();
                c.fillStyle = config.pielabelpercentcolor;
                c.translate(centerx, centery);
                c.rotate(lastend - 0.15 + (Math.PI * 2 * (config.data[0].values[i].Y / totalVal)));
                var dx = Math.floor(centerx * 0.5) + 90;
                var dy = Math.floor(centery * 0.05);
                c.textAlign = "right";
                var fontArgs = c.font.split(' ');
                c.font = config.piefontsize + ' ' + fontArgs[fontArgs.length - 1];
                c.fillText(Math.round((config.data[0].values[i].Y / totalVal) * 100) + "%", dx, dy);
                c.restore();
            }
            // Atualiza o ângulo para a próxima fatia
            lastend += Math.PI * 2 * (config.data[0].values[i].Y / totalVal);
        }
        // Obtém a posição do canvas (para referência, se necessário)
        var canvasOffset = $(graph).offset();
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
    },

    // Desenha o gráfico de barras
    drawBar: function (c, graph) {
        var that = this,
            config = this.options;
        // Itera sobre os valores do primeiro conjunto de dados
        for (var i = 0; i < config.data[0].values.length; i++) {
            var randomcolor;
            c.strokeStyle = config.data[0].linecolor == "Random" ?
                config.data[0].values[i].color = randomcolor = that.getRandomColor() :
                config.data[0].linecolor;
            c.fillStyle = config.data[0].linecolor == "Random" ? randomcolor : config.data[0].linecolor;
            c.beginPath();
            // Desenha cada barra como um retângulo
            c.rect(
                that.pixelX(i, 0) - config.yPadding / 4,
                that.pixelY(config.data[0].values[i].Y),
                config.yPadding / 2,
                graph.height() - that.pixelY(config.data[0].values[i].Y) - config.xPadding + 8
            );
            c.closePath();
            c.stroke();
            c.fill();
            // Exibe o valor da barra
            c.textAlign = "left";
            c.fillStyle = "#000";
            c.fillText(config.data[0].values[i].Y, that.pixelX(i, 0) - config.yPadding / 4, that.pixelY(config.data[0].values[i].Y) + 7, 200);
        }
    },

    // Desenha o gráfico empilhado (stacked)
    drawStacked: function (c, graph) {
        var that = this,
            config = this.options;
        // Percorre cada conjunto de dados e seus valores
        for (var i = 0; i < config.data.length; i++) {
            for (var j = 0; j < config.data[i].values.length; j++) {
                var randomcolor;
                c.strokeStyle = config.data[i].linecolor == "Random" ?
                    config.data[i].values[j].color = randomcolor = that.getRandomColor() :
                    config.data[i].linecolor;
                c.fillStyle = config.data[i].linecolor == "Random" ? randomcolor : config.data[i].linecolor;
                c.beginPath();
                // Desenha a barra empilhada
                c.rect(
                    that.pixelX(j, 0) - config.yPadding / 4,
                    that.pixelY(config.data[i].values[j].Y),
                    config.yPadding / 2,
                    graph.height() - that.pixelY(config.data[i].values[j].Y) - config.xPadding + 8
                );
                c.closePath();
                c.stroke();
                c.fill();
                // Exibe o valor correspondente
                c.textAlign = "left";
                c.fillStyle = "#000";
                c.fillText(config.data[i].values[j].Y, that.pixelX(j, 0) - config.yPadding / 4, that.pixelY(config.data[i].values[j].Y) + 7, 200);
            }
        }
    },

    // Desenha o gráfico híbrido (combinação de linhas e pontos)
    drawHybrid: function (c, graph) {
        var that = this,
            config = this.options;
        var randomcolor;
        // Define a cor da linha
        c.strokeStyle = config.data[0].linecolor == "Random" ?
            randomcolor = that.getRandomColor() :
            config.data[0].linecolor;
        c.beginPath();
        // Conecta os pontos com uma linha
        c.moveTo(that.pixelX(0, 0), that.pixelY(config.data[0].values[0].Y));
        for (var j = 1; j < config.data[0].values.length; j++) {
            c.lineTo(that.pixelX(j, 0), that.pixelY(config.data[0].values[j].Y));
        }
        c.stroke();
        // Desenha os pontos ao longo da linha
        c.fillStyle = config.data[0].linecolor == "Random" ? randomcolor : config.data[0].linecolor;
        for (var j = 0; j < config.data[0].values.length; j++) {
            c.beginPath();
            c.arc(that.pixelX(j, 0), that.pixelY(config.data[0].values[j].Y), 4, 0, Math.PI * 2, true);
            c.fill();
        }
    },

    // Desenha gráficos de linha, área, dispersos e híbridos com tooltip
    drawLineAreaScatteredHybridCharts: function (c, graph) {
        var that = this,
            config = this.options;
        // Cria um canvas para a tooltip e um elemento para a seta (balão)
        var tipCanvas = $(that.element)
            .append("<canvas id='tip'></canvas><div class='down-triangle'></div>")
            .find("#tip")
            .attr('width', config.toolwidth)
            .attr('height', config.toolheight);
        var tipCtx = tipCanvas[0].getContext("2d");
        // Cria um canvas para destacar o ponto sobre o qual o mouse passa
        var highlighter = $(that.element)
            .append("<canvas id='highlighter'></canvas>")
            .find('#highlighter')
            .attr('width', "18")
            .attr('height', "18");
        var higlightctx = highlighter[0].getContext("2d");
        // Seleciona o elemento da seta da tooltip
        var tipbaloontip = $(that.element).find('.down-triangle');
        // Obtém a posição do canvas para cálculo da posição do mouse
        var canvasOffset = $(graph).offset();
        var offsetX = canvasOffset.left;
        var offsetY = canvasOffset.top;
        // Registra o evento de movimento do mouse para exibir a tooltip
        $(graph[0]).on("mousemove", function (e) {
            drawToolTiponHover(e);
        });

        // Percorre cada conjunto de dados para desenhar as linhas, áreas ou pontos
        for (var i = 0; i < config.data.length; i++) {
            c.strokeStyle = config.data[i].linecolor == "Random" ?
                config.data[i].Randomlinecolor = that.getRandomColor() :
                config.data[i].linecolor;
            c.beginPath();
            c.moveTo(that.pixelX(0, i), that.pixelY(config.data[i].values[0].Y));
            // Se o gráfico não for do tipo "Scattered" ou "Hybrid", conecta os pontos com linha
            if (config.ChartType !== "Scattered" && config.ChartType !== "Hybrid") {
                for (var j = 1; j < config.data[i].values.length; j++) {
                    c.lineTo(that.pixelX(j, i), that.pixelY(config.data[i].values[j].Y));
                }
                c.stroke();
            }
            c.fillStyle = config.data[i].linecolor == "Random" ? config.data[i].Randomlinecolor : config.data[i].linecolor;
            if (config.ChartType == "Area") {
                // Fecha o caminho para preencher a área abaixo da linha
                c.lineTo(that.pixelX(config.data[i].values.length - 1, i), that.pixelY(0));
                c.lineTo(that.pixelX(0, 0), that.pixelY(0));
                c.stroke();
                c.fill();
            }
            if (config.ChartType == "Line" || config.ChartType == "Scattered" || config.ChartType == "StackedHybrid") {
                // Desenha os pontos para os gráficos de linha ou dispersos
                for (var j = 0; j < config.data[i].values.length; j++) {
                    c.beginPath();
                    c.arc(that.pixelX(j, i), that.pixelY(config.data[i].values[j].Y), 4, 0, Math.PI * 2, true);
                    c.fill();
                }
            }
        }

        // Cria um array com informações de cada ponto para gerenciamento da tooltip
        var linepoints = [];
        for (var i = 0; i < config.data.length; i++) {
            for (var j = 0; j < config.data[i].values.length; j++) {
                linepoints.push({
                    x: that.pixelX(j, i),
                    y: that.pixelY(config.data[i].values[j].Y),
                    r: 4,
                    rXr: 16,
                    tip: config.data[i].values[j].Y,
                    color: config.data[i].linecolor == "Random" ? config.data[i].Randomlinecolor : config.data[i].linecolor
                });
            }
        }

        // Função para exibir a tooltip ao passar o mouse sobre um ponto
        function drawToolTiponHover(e) {
            // Calcula a posição do mouse relativa ao canvas
            mouseX = parseInt(e.pageX - offsetX);
            mouseY = parseInt(e.pageY - offsetY);
            var hit = false;
            // Verifica se o mouse está sobre algum ponto
            for (var i = 0; i < linepoints.length; i++) {
                var dot = linepoints[i];
                var dx = mouseX - dot.x;
                var dy = mouseY - dot.y;
                if (dx * dx + dy * dy < dot.rXr) {
                    // Posiciona o canvas da tooltip próximo ao ponto
                    tipCanvas[0].style.left = (dot.x - (tipCanvas[0].width / 2)) - 3 + "px";
                    tipCanvas[0].style.top = (dot.y - 21 - tipCanvas[0].height) + config.topmargin + "px";
                    tipCtx.clearRect(0, 0, tipCanvas[0].width, tipCanvas[0].height);
                    tipCtx.fillText(dot.tip, 5, 15);
                    // Posiciona a seta da tooltip
                    tipbaloontip[0].style.left = (dot.x) - 7 + "px";
                    tipbaloontip[0].style.top = (dot.y + config.topmargin) - 19 + "px";
                    // Se o gráfico for de linha, disperso, híbrido ou empilhado híbrido, destaca o ponto
                    if (config.ChartType == "Line" || config.ChartType == "Scattered" || config.ChartType == "Hybrid" || config.ChartType == "StackedHybrid") {
                        highlighter[0].style.left = (dot.x) - 9 + "px";
                        highlighter[0].style.top = (dot.y + config.topmargin) - 9 + "px";
                    }
                    higlightctx.clearRect(0, 0, highlighter.width(), highlighter.height());
                    higlightctx.strokeStyle = dot.color;
                    higlightctx.beginPath();
                    higlightctx.arc(9, 9, 7, 0, 2 * Math.PI);
                    higlightctx.lineWidth = 2;
                    higlightctx.stroke();
                    hit = true;
                }
            }
            // Se o mouse não estiver sobre nenhum ponto, oculta a tooltip e o destaque
            if (!hit) {
                tipCanvas[0].style.left = "-400px";
                highlighter[0].style.left = "-400px";
                tipbaloontip[0].style.left = "-400px";
            }
        }
    },

    // Desenha a legenda do gráfico
    drawLegends: function (graph) {
        var that = this,
            config = this.options;
        // Legendas para gráficos de linha, área, dispersos, empilhados ou empilhados híbridos
        if (config.ChartType == "Line" || config.ChartType == "Area" || config.ChartType == "Scattered" || config.ChartType == "Stacked" || config.ChartType == "StackedHybrid") {
            var _legends = $("<div class='simple-chart-legends' />", { id: "legendsdiv" })
                .css({
                    width: (config.legendposition == 'right' || config.legendposition == 'left') ? (config.legendsize - 5) : graph.width(),
                    height: (config.legendposition == 'top' || config.legendposition == 'bottom') ? (config.legendsize - 5) : graph.height(),
                    float: (config.legendposition == 'right' || config.legendposition == 'left') ? 'left' : ''
                })
                .appendTo($(that.element));
            // Adiciona o título da legenda e cria uma lista para os itens
            var _ul = $(_legends)
                .append("<span>" + config.LegendTitle + "</span>")
                .append("<ul />")
                .find("ul");
            // Para cada conjunto de dados, cria um item na legenda
            for (var i = 0; i < config.data.length; i++) {
                $("<li />", { class: "legendsli" })
                    .append("<span />")
                    .find('span')
                    .addClass("legendindicator")
                    .append('<span class="line" style="background: ' + (config.data[i].linecolor == "Random" ? config.data[i].Randomlinecolor : config.data[i].linecolor) + '"></span><span class="circle" style="background: ' + (config.data[i].linecolor == "Random" ? config.data[i].Randomlinecolor : config.data[i].linecolor) + '"></span>')
                    .parent()
                    .append("<span>" + config.data[i].title + "</span>")
                    .appendTo(_ul);
            }
            // Posiciona a legenda acima ou à esquerda do canvas, conforme configurado
            if (config.legendposition == 'top' || config.legendposition == 'left') {
                $(_legends).insertBefore($(that.element).find('.SimpleChartcanvas'));
            }
            // Define a orientação da legenda (vertical ou horizontal)
            if (config.legendposition == 'right' || config.legendposition == 'left') {
                $(_legends).addClass('vertical');
            } else {
                $(_legends).addClass('horizontal');
            }
        }
        // Legendas para gráficos de barras, híbridos ou de pizza
        if (config.ChartType == "Bar" || config.ChartType == "Hybrid" || config.ChartType == "Pie") {
            var _legends = $("<div class='simple-chart-legends' />", { id: "legendsdiv" })
                .css({
                    width: (config.legendposition == 'right' || config.legendposition == 'left') ? (config.legendsize - 5) : graph.width(),
                    height: (config.legendposition == 'top' || config.legendposition == 'bottom') ? (config.legendsize - 5) : graph.height(),
                    float: (config.legendposition == 'right' || config.legendposition == 'left') ? 'left' : ''
                })
                .appendTo($(that.element));
            var _ul = $(_legends)
                .append("<span>" + config.LegendTitle + "</span>")
                .append("<ul />")
                .find("ul");
            // Para cada valor do primeiro conjunto de dados, cria um item na legenda
            for (var i = 0; i < config.data[0].values.length; i++) {
                $("<li />", { class: "legendsli" })
                    .append("<span />")
                    .find('span')
                    .addClass("legendindicator")
                    .append('<span class="line" style="background: ' + (config.data[0].linecolor == "Random" ? config.data[0].values[i].color : config.data[0].linecolor) + '"></span><span class="circle" style="background: ' + (config.data[0].linecolor == "Random" ? config.data[0].values[i].color : config.data[0].linecolor) + '"></span>')
                    .parent()
                    .append("<span>" + config.data[0].values[i].X + "</span><span class='legendvalue'>" + (config.ChartType == 'Pie' ? config.data[0].values[i].Y : '') + "</span>")
                    .appendTo(_ul);
            }
            if (config.legendposition == 'top' || config.legendposition == 'left') {
                $(_legends).insertBefore($(that.element).find('.SimpleChartcanvas'));
            }
            if (config.legendposition == 'right' || config.legendposition == 'left') {
                $(_legends).addClass('vertical');
            } else {
                $(_legends).addClass('horizontal');
            }
        }
    }
};



    $.fn[pluginName] = function (options) {
        if (typeof options === "string") {
            var args = Array.prototype.slice.call(arguments, 1);
            this.each(function () {
                var plugin = $.data(this, 'plugin_' + pluginName);
                if (plugin[options]) {
                    plugin[options].apply(plugin, args);
                } else {
                    plugin['options'][options] = args[0];
                }
            });
        } else {
            return this.each(function () {
                if (!$.data(this, 'plugin_' + pluginName)) {
                    $.data(this, 'plugin_' + pluginName, new Plugin(this, options));
                }
            });
        }
    }
})(jQuery, window, document, undefined);
