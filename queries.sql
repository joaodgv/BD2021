<<<<<<< HEAD
-- 1 
SELECT nome FROM concelho NATURAL JOIN
(SELECT num_concelho, num_regiao, preco
FROM venda_farmacia INNER JOIN instituicao
ON venda_farmacia.inst = instituicao.nome) AS foo
GROUP BY nome
HAVING SUM(preco) >= ALL
(SELECT SUM(preco) FROM venda_farmacia INNER JOIN instituicao
ON venda_farmacia.inst = instituicao.nome GROUP BY (num_concelho, num_regiao));

-- 2
SELECT num_cedula, num_regiao FROM 
(SELECT num_cedula, num_regiao, SUM(quantidade) total_qtd from prescricao NATURAL JOIN consulta INNER JOIN instituicao
ON instituicao.nome = consulta.nome_instituicao
GROUP BY (num_regiao, num_cedula)) AS foo

NATURAL JOIN 

(
SELECT num_regiao, MAX(total_qtd) 
FROM(
    SELECT num_regiao, SUM(quantidade) total_qtd from prescricao NATURAL JOIN consulta INNER JOIN instituicao
    ON instituicao.nome = consulta.nome_instituicao
    GROUP BY (num_regiao, num_cedula)
    ) AS bar
GROUP BY num_regiao ) AS foobar
WHERE total_qtd = max
);

-- 3
SELECT DISTINCT num_cedula FROM prescricao_venda p
WHERE NOT EXISTS (
    SELECT instituicao.nome FROM instituicao INNER JOIN concelho
    ON instituicao.num_concelho = concelho.num_concelho
    WHERE concelho.nome = 'Arouca' AND instituicao.tipo = 'Farmácia'

    EXCEPT

    SELECT DISTINCT instituicao.nome FROM
    prescricao_venda NATURAL JOIN venda_farmacia
    INNER JOIN instituicao ON inst = instituicao.nome
    WHERE substancia = 'Aspirina'
    AND p.num_cedula = prescricao_venda.num_cedula
    AND instituicao.tipo = 'Farmácia'
    AND EXTRACT(YEAR FROM prescricao_venda.data) = EXTRACT(YEAR from current_date)
);
--4

SELECT num_doente FROM analise 
EXCEPT
SELECT num_doente FROM prescricao_venda
WHERE EXTRACT(MONTH FROM data) = EXTRACT(MONTH from current_date)
AND EXTRACT(YEAR FROM data) = EXTRACT(YEAR from current_date);
