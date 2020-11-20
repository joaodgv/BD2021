-- 1 
SELECT nome FROM Concelho NATURAL JOIN
(SELECT num_concelho, num_regiao, preco
FROM VendaFarmacia INNER JOIN Instituicao
ON VendaFarmacia.inst = Instituicao.nome) AS foo
GROUP BY nome
HAVING SUM(preco) >= ALL
(SELECT SUM(preco) FROM VendaFarmacia INNER JOIN Instituicao
ON VendaFarmacia.inst = Instituicao.nome GROUP BY (num_concelho, num_regiao));

-- 2
SELECT num_cedula, num_regiao FROM 
(SELECT num_cedula, num_regiao, SUM(quantidade) total_qtd from Prescricao NATURAL JOIN Consulta INNER JOIN Instituicao
ON Instituicao.nome = Consulta.nome_Instituicao
GROUP BY (num_regiao, num_cedula)) AS foo
NATURAL JOIN 
(
	SELECT num_regiao, MAX(total_qtd) 
	FROM(
		SELECT num_regiao, SUM(quantidade) total_qtd from Prescricao NATURAL JOIN Consulta INNER JOIN Instituicao
		ON Instituicao.nome = Consulta.nome_Instituicao
		GROUP BY (num_regiao, num_cedula)
		) AS bar
	GROUP BY num_regiao ) AS foobar
	WHERE total_qtd = max
);

-- 3
SELECT DISTINCT num_cedula FROM PrescricaoVenda p
WHERE NOT EXISTS (
    SELECT Instituicao.nome FROM Instituicao INNER JOIN Concelho
    ON Instituicao.num_concelho = Concelho.num_concelho
    WHERE Concelho.nome = 'Arouca' AND Instituicao.tipo = 'Farmácia'

    EXCEPT

    SELECT DISTINCT Instituicao.nome FROM
    PrescricaoVenda NATURAL JOIN VendaFarmacia
    INNER JOIN Instituicao ON inst = Instituicao.nome
    WHERE substancia = 'Aspirina'
    AND p.num_cedula = PrescricaoVenda.num_cedula
    AND Instituicao.tipo = 'Farmácia'
    AND EXTRACT(YEAR FROM PrescricaoVenda.data) = EXTRACT(YEAR from current_date)
);
--4

SELECT num_doente FROM Analise 
EXCEPT
SELECT num_doente FROM PrescricaoVenda
WHERE EXTRACT(MONTH FROM data) = EXTRACT(MONTH from current_date)
AND EXTRACT(YEAR FROM data) = EXTRACT(YEAR from current_date);
