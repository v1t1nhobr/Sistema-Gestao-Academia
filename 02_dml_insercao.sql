CREATE EXTENSION IF NOT EXISTS pgcrypto;
INSERT INTO usuarios
(id, nome, email, telefone, tipo_perfil, password_hash)
VALUES
(1, 'Carlos Almeida', 'carlos@exemplo.com', '71999990001', 'ADMIN', crypt('senha1', gen_salt('bf'))),
(2, 'Amanda', 'amanda@exemplo.com', '71999990002', 'ALUNO', crypt('senha2', gen_salt('bf'))),
(3, 'Pedro Santos', 'pedro@exemplo.com', '71999990003', 'ALUNO', crypt('senha3', gen_salt('bf'))),
(4, 'Mariana Lima', 'mariana@exemplo.com', '71999990004', 'ALUNO', crypt('senha4', gen_salt('bf'))),
(5, 'Lucas Ferreira', 'lucas@exemplo.com', '71999990005', 'ALUNO', crypt('senha5', gen_salt('bf')));
SELECT id, nome, password_hash
FROM usuarios
ORDER BY id;

INSERT INTO equipamentos
(id, nome, categoria, numero_serie, ativo, observacoes)
VALUES
(1, 'Esteira Eletrica', 'Cardio', 'EST001', TRUE, 'Em funcionamento'),
(2, 'Bicicleta Ergometrica', 'Cardio', 'BIC002', TRUE, 'Uso diario'),
(3, 'Leg Press', 'Musculacao', 'LEG003', TRUE, 'Equipamento revisado'),
(4, 'Supino Reto', 'Musculacao', 'SUP004', TRUE, 'Bom estado'),
(5, 'Puxador Alto', 'Musculacao', 'PUX005', FALSE, 'Aguardando reparo');

SELECT * FROM equipamentos
ORDER BY id;

-- INSERCAO DE MENSALIDADES

INSERT INTO mensalidades
(id, usuario_id, valor, data_vencimento, data_pagamento, status)
VALUES
(1, 2, 120.00, '2026-10-05', '2026-10-04', 'PAGA'),
(2, 3, 120.00, '2026-10-10', '2026-10-09', 'PAGA'),
(3, 4, 150.00, '2026-10-15', NULL, 'ATRASADA'),
(4, 5, 120.00, '2026-11-05', NULL, 'PENDENTE'),
(5, 2, 120.00, '2026-11-05', NULL, 'PENDENTE');

SELECT
    u.nome AS aluno,
    m.valor,
    m.data_vencimento,
    m.data_pagamento,
    m.status
FROM mensalidades m
INNER JOIN usuarios u
    ON m.usuario_id = u.id
ORDER BY m.id;

-- INSERCAO DE TREINOS

INSERT INTO treinos
(id, usuario_id, descricao, duracao_minutos)
VALUES
(1, 2, 'Treino de membros inferiores', 60),
(2, 3, 'Treino de peito e triceps', 50),
(3, 4, 'Treino de costas e biceps', 55),
(4, 5, 'Treino cardiovascular', 40),
(5, 2, 'Treino de superiores', 45);

SELECT
    t.id,
    u.nome AS aluno,
    t.descricao AS treino,
    t.duracao_minutos
FROM treinos t
INNER JOIN usuarios u
    ON t.usuario_id = u.id
ORDER BY t.id;

-- INSERCAO DE MANUTENCOES

INSERT INTO manutencoes
(id, equipamento_id, tipo, descricao, custo, data_manutencao)
VALUES
(1, 1, 'PREVENTIVA', 'Lubrificacao da esteira', 80.00, '2026-09-10'),
(2, 2, 'PREVENTIVA', 'Verificacao dos pedais', 50.00, '2026-09-12'),
(3, 3, 'CORRETIVA', 'Troca de cabo', 180.00, '2026-09-15'),
(4, 4, 'PREVENTIVA', 'Aperto de parafusos', 30.00, '2026-09-18'),
(5, 5, 'CORRETIVA', 'Substituicao de polia', 140.00, '2026-10-02');

SELECT
    m.id,
    e.nome AS equipamento,
    m.tipo,
    m.descricao,
    m.custo,
    m.data_manutencao
FROM manutencoes m
INNER JOIN equipamentos e
    ON m.equipamento_id = e.id
ORDER BY m.id;

-- INSERCAO DE ITENS DE TREINO

INSERT INTO itens_treino
(id, treino_id, equipamento_id, exercicio, series, repeticoes, observacoes)
VALUES
(1, 1, 3, 'Leg Press', 4, 12, 'Carga moderada'),
(2, 2, 4, 'Supino Reto', 4, 10, 'Intervalo de 60 segundos'),
(3, 3, 5, 'Puxada Alta', 3, 12, 'Movimento controlado'),
(4, 4, 1, 'Caminhada na Esteira', 1, 30, '30 minutos de caminhada'),
(5, 5, NULL, 'Flexao de Braco', 3, 15, 'Exercicio com peso corporal');

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
ORDER BY i.id;

SELECT 'usuarios' AS tabela, COUNT(*) AS quantidade FROM usuarios
UNION ALL
SELECT 'equipamentos', COUNT(*) FROM equipamentos
UNION ALL
SELECT 'mensalidades', COUNT(*) FROM mensalidades
UNION ALL
SELECT 'treinos', COUNT(*) FROM treinos
UNION ALL
SELECT 'manutencoes', COUNT(*) FROM manutencoes
UNION ALL
SELECT 'itens_treino', COUNT(*) FROM itens_treino;

SELECT setval(pg_get_serial_sequence('usuarios', 'id'), (SELECT MAX(id) FROM usuarios));
SELECT setval(pg_get_serial_sequence('equipamentos', 'id'), (SELECT MAX(id) FROM equipamentos));
SELECT setval(pg_get_serial_sequence('mensalidades', 'id'), (SELECT MAX(id) FROM mensalidades));
SELECT setval(pg_get_serial_sequence('treinos', 'id'), (SELECT MAX(id) FROM treinos));
SELECT setval(pg_get_serial_sequence('manutencoes', 'id'), (SELECT MAX(id) FROM manutencoes));
SELECT setval(pg_get_serial_sequence('itens_treino', 'id'), (SELECT MAX(id) FROM itens_treino));


