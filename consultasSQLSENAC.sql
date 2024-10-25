-- Primeiro relatório --

SELECT e.nome AS 'Nome Empregado', 
       e.cpf AS 'CPF Empregado', 
       e.dataAdm AS 'Data Admissão', 
       e.salario AS 'Salário', 
       d.nome AS 'Departamento', 
       t.numero AS 'Número de Telefone'
FROM petshop.Empregado e
JOIN petshop.Departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN petshop.Telefone t ON e.cpf = t.Empregado_cpf
WHERE e.dataAdm >= '2023-01-01 00:00:00' AND e.dataAdm <= '2023-03-31 00:00:00'
ORDER BY e.dataAdm DESC;

-- não existe empregados de 2019 até 2022  

SELECT dataAdm FROM petshop.Empregado;


-- Segundo relatório --

SELECT e.nome AS 'Nome Empregado', 
       e.cpf AS 'CPF Empregado', 
       e.dataAdm AS 'Data Admissão', 
       e.salario AS 'Salário', 
       d.nome AS 'Departamento', 
       t.numero AS 'Número de Telefone'
FROM Empregado e
JOIN Departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN Telefone t ON e.cpf = t.Empregado_cpf
WHERE e.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY e.nome;

-- Terceiro relatório --

SELECT d.nome AS 'Departamento', 
       COUNT(e.cpf) AS 'Quantidade de Empregados', 
       AVG(e.salario) AS 'Média Salarial', 
       AVG(e.comissao) AS 'Média da Comissão'
FROM Departamento d
JOIN Empregado e ON d.idDepartamento = e.Departamento_idDepartamento
GROUP BY d.nome
ORDER BY d.nome;

-- Quarto relatorio --

SELECT e.nome AS 'Nome Empregado', 
       e.cpf AS 'CPF Empregado', 
       e.sexo AS 'Sexo', 
       e.salario AS 'Salário', 
       COUNT(v.idVenda) AS 'Quantidade Vendas', 
       SUM(v.valor) AS 'Total Valor Vendido', 
       SUM(v.comissao) AS 'Total Comissão das Vendas'
FROM Empregado e
JOIN Venda v ON e.cpf = v.Empregado_cpf
GROUP BY e.cpf
ORDER BY COUNT(v.idVenda) DESC;

-- Quinto relatorio --

SELECT e.nome AS 'Nome Empregado', 
       e.cpf AS 'CPF Empregado', 
       e.sexo AS 'Sexo', 
       e.salario AS 'Salário', 
       COUNT(DISTINCT i.Venda_idVenda) AS 'Quantidade Vendas com Serviço', 
       SUM(i.valor) AS 'Total Valor Vendido com Serviço', 
       SUM(v.comissao) AS 'Total Comissão das Vendas com Serviço'
FROM Empregado e
JOIN itensServico i ON e.cpf = i.Empregado_cpf
JOIN Venda v ON i.Venda_idVenda = v.idVenda
GROUP BY e.cpf
ORDER BY COUNT(DISTINCT i.Venda_idVenda) DESC;

-- Sexto relatorio --

SELECT p.nome AS 'Nome do Pet', 
       s.nome AS 'Nome do Serviço', 
       i.quantidade AS 'Quantidade', 
       i.valor AS 'Valor', 
       e.nome AS 'Empregado que realizou o Serviço', 
       v.data AS 'Data do Serviço'
FROM PET p
JOIN itensServico i ON p.idPET = i.PET_idPET
JOIN Servico s ON i.Servico_idServico = s.idServico
JOIN Empregado e ON i.Empregado_cpf = e.cpf
JOIN Venda v ON i.Venda_idVenda = v.idVenda
ORDER BY v.data DESC;

-- Sétimo relatorio --

SELECT v.data AS 'Data da Venda', 
       v.valor AS 'Valor', 
       v.desconto AS 'Desconto', 
       (v.valor - v.desconto) AS 'Valor Final', 
       e.nome AS 'Empregado que realizou a venda'
FROM Venda v
JOIN Empregado e ON v.Empregado_cpf = e.cpf
WHERE v.Cliente_cpf = 'CPF_DO_CLIENTE' -- Substituir pelo CPF do cliente desejado
ORDER BY v.data DESC;

-- Oitavo relatorio --

SELECT s.nome AS 'Nome do Serviço', 
       COUNT(i.Servico_idServico) AS 'Quantidade Vendas', 
       SUM(i.valor) AS 'Total Valor Vendido'
FROM itensServico i
JOIN Servico s ON i.Servico_idServico = s.idServico
GROUP BY s.nome
ORDER BY COUNT(i.Servico_idServico) DESC
LIMIT 10;

-- Nono relatorio --

SELECT f.tipo AS 'Tipo Forma Pagamento', 
       COUNT(f.Venda_idVenda) AS 'Quantidade Vendas', 
       SUM(f.valorPago) AS 'Total Valor Vendido'
FROM FormaPgVenda f
GROUP BY f.tipo
ORDER BY COUNT(f.Venda_idVenda) DESC;

-- Décimo relatorio --

SELECT DATE(v.data) AS 'Data Venda', 
       COUNT(v.idVenda) AS 'Quantidade de Vendas', 
       SUM(v.valor) AS 'Valor Total Venda'
FROM Venda v
GROUP BY DATE(v.data)
ORDER BY DATE(v.data) DESC;

-- Décimo primeiro relatorio --

SELECT p.nome AS 'Nome Produto', 
       p.valorVenda AS 'Valor Produto', 
       f.nome AS 'Nome Fornecedor', 
       f.email AS 'Email Fornecedor', 
       t.numero AS 'Telefone Fornecedor'
FROM Produtos p
JOIN ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
JOIN Compras c ON ic.Compras_idCompra = c.idCompra
JOIN Fornecedor f ON c.Fornecedor_cpf_cnpj = f.cpf_cnpj
LEFT JOIN Telefone t ON f.cpf_cnpj = t.Fornecedor_cpf_cnpj
ORDER BY p.nome;


-- Décimo segundo relatorio -- 

SELECT 
    p.nome AS Nome_Produto,
    COUNT(ivp.Produto_idProduto) AS Quantidade_Vendas,
    SUM(ivp.valor * ivp.quantidade) AS Valor_Total_Recebido
FROM 
    ItensVendaProd ivp
JOIN 
    Produtos p ON ivp.Produto_idProduto = p.idProduto
GROUP BY 
    p.nome
ORDER BY 
    Quantidade_Vendas DESC;

