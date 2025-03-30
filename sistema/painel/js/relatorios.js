// Configuração global
const { jsPDF } = window.jspdf;

// Função principal para todos os relatórios
function gerarRelatorio(tipo) {
    // Obter dados do formulário
    const modalId = `Rel${tipo.charAt(0).toUpperCase() + tipo.slice(1)}`;
    const form = document.getElementById(`form-rel-${tipo}`);
    const formData = new FormData(form);
    
    // Mostrar loading
    Swal.fire({
        title: 'Gerando relatório',
        html: 'Por favor, aguarde...',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // Buscar dados
    fetch(`rel/rel_${tipo}_class.php`, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        switch(tipo) {
            case 'entradas':
                gerarPDFEntradas(data);
                break;
            case 'saidas':
                gerarPDFSaidas(data);
                break;
            case 'comissoes':
                gerarPDFComissoes(data);
                break;
            case 'con':
                gerarPDFContas(data);
                break;
            case 'lucro':
                gerarPDFLucro(data);
                break;
            case 'aniv':
                gerarPDFAniversariantes(data);
                break;
        }
        Swal.close();
    })
    .catch(error => {
        console.error('Error:', error);
        Swal.fire('Erro', 'Não foi possível gerar o relatório', 'error');
    });
}

// ========== FUNÇÕES ESPECÍFICAS PARA CADA RELATÓRIO ==========

// 1. Relatório de Entradas
function gerarPDFEntradas(dados) {
    const doc = new jsPDF();
    
    // Cabeçalho
    doc.setFontSize(18);
    doc.text('Relatório de Entradas', 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    
    if(dados.filtro && dados.filtro !== 'Todos') {
        doc.text(`Filtro: ${dados.filtro}`, 14, 32);
    }
    
    // Tabela
    doc.autoTable({
        head: [['Data', 'Descrição', 'Valor (R$)', 'Tipo']],
        body: dados.itens.map(item => [
            formatarData(item.data),
            item.descricao,
            formatarMoeda(item.valor),
            item.tipo
        ]),
        startY: 40,
        columnStyles: {
            0: { cellWidth: 25 },
            1: { cellWidth: 80 },
            2: { cellWidth: 30, halign: 'right' },
            3: { cellWidth: 40 }
        }
    });
    
    // Total
    doc.setFontSize(12);
    doc.text(`Total: ${formatarMoeda(dados.total)}`, 14, doc.lastAutoTable.finalY + 10);
    
    // Rodapé
    addRodape(doc);
    doc.save(`relatorio_entradas_${new Date().toISOString().slice(0,10)}.pdf`);
}

// 2. Relatório de Saídas
function gerarPDFSaidas(dados) {
    const doc = new jsPDF();
    
    doc.setFontSize(18);
    doc.text('Relatório de Saídas', 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    
    if(dados.filtro && dados.filtro !== 'Todos') {
        doc.text(`Filtro: ${dados.filtro}`, 14, 32);
    }
    
    doc.autoTable({
        head: [['Data', 'Descrição', 'Valor (R$)', 'Tipo', 'Pago']],
        body: dados.itens.map(item => [
            formatarData(item.data),
            item.descricao,
            formatarMoeda(item.valor),
            item.tipo,
            item.pago === 'Sim' ? '✓' : '✗'
        ]),
        startY: 40,
        columnStyles: {
            0: { cellWidth: 25 },
            1: { cellWidth: 70 },
            2: { cellWidth: 25, halign: 'right' },
            3: { cellWidth: 30 },
            4: { cellWidth: 15, halign: 'center' }
        }
    });
    
    doc.setFontSize(12);
    doc.text(`Total: ${formatarMoeda(dados.total)}`, 14, doc.lastAutoTable.finalY + 10);
    
    addRodape(doc);
    doc.save(`relatorio_saidas_${new Date().toISOString().slice(0,10)}.pdf`);
}

// 3. Relatório de Comissões
function gerarPDFComissoes(dados) {
    const doc = new jsPDF();
    
    doc.setFontSize(18);
    doc.text('Relatório de Comissões', 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    
    if(dados.funcionario) {
        doc.text(`Funcionário: ${dados.funcionario}`, 14, 32);
    }
    
    doc.autoTable({
        head: [['Data', 'Funcionário', 'Serviço', 'Valor (R$)', 'Comissão', 'Pago']],
        body: dados.itens.map(item => [
            formatarData(item.data),
            item.funcionario,
            item.servico,
            formatarMoeda(item.valor),
            formatarMoeda(item.comissao),
            item.pago === 'Sim' ? '✓' : '✗'
        ]),
        startY: 40,
        columnStyles: {
            0: { cellWidth: 20 },
            1: { cellWidth: 40 },
            2: { cellWidth: 50 },
            3: { cellWidth: 25, halign: 'right' },
            4: { cellWidth: 25, halign: 'right' },
            5: { cellWidth: 15, halign: 'center' }
        }
    });
    
    doc.setFontSize(12);
    doc.text(`Total Comissões: ${formatarMoeda(dados.total)}`, 14, doc.lastAutoTable.finalY + 10);
    
    addRodape(doc);
    doc.save(`relatorio_comissoes_${new Date().toISOString().slice(0,10)}.pdf`);
}

// 4. Relatório de Contas (Pagar/Receber)
function gerarPDFContas(dados) {
    const doc = new jsPDF();
    const titulo = dados.tipo === 'pagar' ? 'Contas a Pagar' : 'Contas a Receber';
    
    doc.setFontSize(18);
    doc.text(`Relatório de ${titulo}`, 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    doc.text(`Ordenado por: ${dados.ordenadoPor === 'data_venc' ? 'Vencimento' : 'Pagamento'}`, 14, 32);
    
    if(dados.pago) {
        doc.text(`Status: ${dados.pago === 'Sim' ? 'Pagas' : 'Pendentes'}`, 14, 39);
    }
    
    const columns = [
        { title: "Vencimento", dataKey: "vencimento" },
        { title: "Descrição", dataKey: "descricao" },
        { title: "Valor (R$)", dataKey: "valor" },
        { title: "Status", dataKey: "pago" }
    ];
    
    if(dados.ordenadoPor === 'data_pgto') {
        columns.unshift({ title: "Pagamento", dataKey: "pagamento" });
    }
    
    doc.autoTable({
        head: [columns.map(col => col.title)],
        body: dados.itens.map(item => {
            const row = [
                formatarData(item.vencimento),
                item.descricao,
                formatarMoeda(item.valor),
                item.pago === 'Sim' ? 'Pago' : 'Pendente'
            ];
            
            if(dados.ordenadoPor === 'data_pgto') {
                row.unshift(item.pagamento ? formatarData(item.pagamento) : '-');
            }
            
            return row;
        }),
        startY: 50,
        columnStyles: {
            0: { cellWidth: dados.ordenadoPor === 'data_pgto' ? 20 : 25 },
            [dados.ordenadoPor === 'data_pgto' ? 1 : 0]: { cellWidth: 25 },
            [dados.ordenadoPor === 'data_pgto' ? 2 : 1]: { cellWidth: 70 },
            [dados.ordenadoPor === 'data_pgto' ? 3 : 2]: { cellWidth: 25, halign: 'right' },
            [dados.ordenadoPor === 'data_pgto' ? 4 : 3]: { cellWidth: 25, halign: 'center' }
        }
    });
    
    doc.setFontSize(12);
    doc.text(`Total: ${formatarMoeda(dados.total)}`, 14, doc.lastAutoTable.finalY + 10);
    
    addRodape(doc);
    doc.save(`relatorio_${dados.tipo}_${new Date().toISOString().slice(0,10)}.pdf`);
}

// 5. Relatório de Demonstrativo de Lucro
function gerarPDFLucro(dados) {
    const doc = new jsPDF();
    
    doc.setFontSize(18);
    doc.text('Demonstrativo de Lucro', 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    
    // Tabela de Resumo
    doc.autoTable({
        head: [['Item', 'Valor (R$)']],
        body: [
            ['Total de Entradas', formatarMoeda(dados.totalEntradas)],
            ['Total de Saídas', formatarMoeda(dados.totalSaidas)],
            ['Lucro Líquido', formatarMoeda(dados.lucro)],
            ['Margem de Lucro', `${dados.margem}%`]
        ],
        startY: 35,
        columnStyles: {
            0: { cellWidth: 70, fontStyle: 'bold' },
            1: { cellWidth: 30, halign: 'right' }
        }
    });
    
    // Gráfico (simplificado)
    const startY = doc.lastAutoTable.finalY + 15;
    doc.setFillColor(100, 100, 255);
    doc.rect(20, startY, 40, 50, 'F'); // Entradas
    doc.setFillColor(255, 100, 100);
    doc.rect(70, startY, 40, 50 * (dados.totalSaidas / dados.totalEntradas), 'F'); // Saídas
    
    doc.setFontSize(10);
    doc.text('Entradas', 40, startY + 60);
    doc.text('Saídas', 90, startY + 60);
    
    addRodape(doc);
    doc.save(`demonstrativo_lucro_${new Date().toISOString().slice(0,10)}.pdf`);
}

// 6. Relatório de Aniversariantes
function gerarPDFAniversariantes(dados) {
    const doc = new jsPDF();
    
    doc.setFontSize(18);
    doc.text('Relatório de Aniversariantes', 105, 15, { align: 'center' });
    
    doc.setFontSize(12);
    doc.text(`Período: ${formatarData(dados.periodo.dataInicial)} à ${formatarData(dados.periodo.dataFinal)}`, 14, 25);
    
    doc.autoTable({
        head: [['Nome', 'Telefone', 'Data Nasc.', 'Idade', 'E-mail']],
        body: dados.itens.map(item => [
            item.nome,
            item.telefone,
            formatarData(item.data_nasc),
            item.idade,
            item.email || '-'
        ]),
        startY: 35,
        columnStyles: {
            0: { cellWidth: 50 },
            1: { cellWidth: 30 },
            2: { cellWidth: 25 },
            3: { cellWidth: 15, halign: 'center' },
            4: { cellWidth: 60 }
        }
    });
    
    doc.setFontSize(12);
    doc.text(`Total: ${dados.itens.length} aniversariantes`, 14, doc.lastAutoTable.finalY + 10);
    
    addRodape(doc);
    doc.save(`aniversariantes_${new Date().toISOString().slice(0,10)}.pdf`);
}

// ========== FUNÇÕES AUXILIARES ==========

function formatarData(dataStr) {
    if(!dataStr) return '-';
    const data = new Date(dataStr);
    return data.toLocaleDateString('pt-BR');
}

function formatarMoeda(valor) {
    return parseFloat(valor).toLocaleString('pt-BR', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
}

function addRodape(doc) {
    doc.setFontSize(10);
    doc.text(`Gerado em: ${new Date().toLocaleString()}`, 105, doc.internal.pageSize.height - 10, { align: 'center' });
    doc.text(`Sistema ${nomeSistema}`, 105, doc.internal.pageSize.height - 5, { align: 'center' });
}

// Variável global com o nome do sistema (defina isso em seu layout principal)
const nomeSistema = "<?php echo $nome_sistema ?>";