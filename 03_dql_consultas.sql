
-- PROJETO: SISTEMA DE GESTAO DE ACADEMIA
-- SCRIPT: 03_dql_consultas.sql
-- SGBD: POSTGRESQL

-- ============================================
-- CONSULTA 1: ALUNOS ATIVOS
-- WHERE, AND, LIKE E ORDER BY
-- ============================================

SELECT
    id,
    nome,
    email,
    tipo_perfil
FROM usuarios
WHERE ativo = TRUE
  AND tipo_perfil = 'ALUNO'
  AND nome LIKE '%a%'
ORDER BY nome ASC;


-- ============================================
-- CONSULTA 2: MENSALIDADES EM ABERTO
-- IN, BETWEEN E ORDER BY
-- ============================================

SELECT
    id,
    usuario_id,
    valor,
    data_vencimento,
    status
FROM mensalidades
WHERE status IN ('PENDENTE', 'ATRASADA')
  AND valor BETWEEN 100 AND 200
ORDER BY data_vencimento ASC;


-- ============================================
-- CONSULTA 3: ALUNOS E MENSALIDADES
-- INNER JOIN
-- ============================================

SELECT
    u.nome AS aluno,
    m.valor,
    m.data_vencimento,
    m.data_pagamento,
    m.status
FROM usuarios u
INNER JOIN mensalidades m
    ON u.id = m.usuario_id
ORDER BY u.nome, m.data_vencimento;


-- ============================================
-- CONSULTA 4: USUARIOS E SEUS TREINOS
-- LEFT JOIN
-- ============================================

SELECT
    u.nome AS usuario,
    u.tipo_perfil,
    t.descricao AS treino,
    t.duracao_minutos
FROM usuarios u
LEFT JOIN treinos t
    ON u.id = t.usuario_id
ORDER BY u.nome, t.id;


-- ============================================
-- CONSULTA 5: EXERCICIOS E EQUIPAMENTOS
-- INNER JOIN E LEFT JOIN
-- ============================================

SELECT
    u.nome AS aluno,
    t.descricao AS treino,
    i.exercicio,
    i.series,
    i.repeticoes,
    COALESCE(e.nome, 'Sem equipamento') AS equipamento
FROM itens_treino i
INNER JOIN treinos t
    ON i.treino_id = t.id
INNER JOIN usuarios u
    ON t.usuario_id = u.id
LEFT JOIN equipamentos e
    ON i.equipamento_id = e.id
ORDER BY u.nome, i.id;


-- ============================================
-- CONSULTA 6: ALUNOS COM MAIS DE UM TREINO
-- COUNT, GROUP BY E HAVING
-- ============================================

SELECT
    u.nome AS aluno,
    COUNT(t.id) AS total_treinos
FROM usuarios u
INNER JOIN treinos t
    ON u.id = t.usuario_id
GROUP BY u.id, u.nome
HAVING COUNT(t.id) > 1
ORDER BY total_treinos DESC;


-- ============================================
-- CONSULTA 7: CUSTOS DE MANUTENCAO POR TIPO
-- SUM, AVG, GROUP BY E HAVING
-- ============================================

SELECT
    tipo,
    COUNT(*) AS quantidade_manutencoes,
    SUM(custo) AS custo_total,
    ROUND(AVG(custo), 2) AS custo_medio
FROM manutencoes
GROUP BY tipo
HAVING SUM(custo) > 100
ORDER BY custo_total DESC;


-- ============================================
-- CONSULTA 8: MENSALIDADES ACIMA DA MEDIA
-- SUBCONSULTA
-- ============================================

SELECT
    u.nome AS aluno,
    m.valor,
    m.data_vencimento,
    m.status
FROM mensalidades m
INNER JOIN usuarios u
    ON m.usuario_id = u.id
WHERE m.valor > (
    SELECT AVG(valor)
    FROM mensalidades
)
ORDER BY m.valor DESC, u.nome;
