USE livraria ;

-- 1. Calcule o valor total de cada venda.
-- 2. Qual cliente gastou mais em suas compras? 
-- 3. Liste todos os clientes que compraram o livro 'O Pequeno Príncipe'.
-- 4. Liste todos os livros que foram vendidos mais de uma vez.
-- 5. Quais clientes compraram mais de um livro em uma única venda?

SELECT * FROM clientes ;
SELECT * FROM livros ;
SELECT * FROM vendedor ;
SELECT * FROM vendas ;

-- 1. CALCULAR O VALOR TOTAL DE CADA VENDA 
SELECT 
    v.idvendas AS venda_id,
    SUM(l.valor * vh.quantidade) AS valor_total
FROM 
    vendas v
JOIN 
    vendas_has_livros vh ON v.idvendas = vh.vendas_idvendas
JOIN 
    livros l ON vh.livros_idlivros = l.idlivros
GROUP BY 
    v.idvendas;
-- -----------------------------------------------------------------------
-- -----------------------------------------------------------------------
-- QUAL CLIENTE GASTOU MAIS EM SUAS COMPRAS?
SELECT 
    c.idclientes AS cliente_id,
    c.nome AS cliente_nome,
    SUM(l.valor * vh.quantidade) AS total_gasto
FROM 
    clientes c
JOIN 
    vendas v ON c.idclientes = v.clientes_idclientes
JOIN 
    vendas_has_livros vh ON v.idvendas = vh.vendas_idvendas
JOIN 
    livros l ON vh.livros_idlivros = l.idlivros
GROUP BY 
    c.idclientes
ORDER BY 
    total_gasto DESC
LIMIT 1;
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- LISTE TODOS OS CLIENTES QUE COMPRARAM O LIVRO 'O PEQUENO PRÍNCIPE'
SELECT 
    c.idclientes AS cliente_id,
    c.nome AS cliente_nome,
    c.email AS cliente_email
FROM 
    clientes c
JOIN 
    vendas v ON c.idclientes = v.clientes_idclientes
JOIN 
    vendas_has_livros vh ON v.idvendas = vh.vendas_idvendas
JOIN 
    livros l ON vh.livros_idlivros = l.idlivros
WHERE 
    l.descricao = 'O Pequeno Príncipe';
-- --------------------------------------------------------------
-- ---------------------------------------------------------------
 -- lISTE TODOS OS LIVROS QUE FORAM VENDIDOS MAIS DE UMA VEZ
SELECT 
    l.idlivros AS livro_id,
    l.descricao AS livro_descricao,
    COUNT(vh.vendas_idvendas) AS total_vendas
FROM 
    livros l
JOIN 
    vendas_has_livros vh ON l.idlivros = vh.livros_idlivros
GROUP BY 
    l.idlivros, l.descricao
HAVING 
    COUNT(vh.vendas_idvendas) > 1;

-- ------------------------------------------------------------
-- -------------------------------------------------------------
-- QUAIS CLIENTES COMPRARAM MAIS DE UM LIVRO NUMA ÚNICA VENDA ?

SELECT 
    c.idclientes AS cliente_id,
    c.nome AS cliente_nome,
    v.idvendas AS venda_id,
    COUNT(vh.livros_idlivros) AS total_livros_comprados
FROM 
    clientes c
JOIN 
    vendas v ON c.idclientes = v.clientes_idclientes
JOIN 
    vendas_has_livros vh ON v.idvendas = vh.vendas_idvendas
GROUP BY 
    c.idclientes, v.idvendas
HAVING 
    COUNT(vh.livros_idlivros) > 1;
