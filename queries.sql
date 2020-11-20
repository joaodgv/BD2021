-- 1 
SELECT concelho.nome FROM instituicao natural join vendafarmacia
INNER JOIN Concelho on Concelho.num_concelho = instituicao.num_concelho
where instituicao.nome = vendafarmacia.inst AND data_registo = CURRENT_DATE
GROUP BY concelho.nome
HAVING SUM(preco) >= ALL
(SELECT SUM(preco) FROM instituicao natural join vendafarmacia
INNER JOIN Concelho on Concelho.num_concelho = instituicao.num_concelho
where instituicao.nome = vendafarmacia.inst AND data_registo = CURRENT_DATE
GROUP BY concelho.nome);

-- 2
SELECT num_cedula, num_regiao FROM 
	(SELECT num_cedula, num_regiao, COUNT(num_cedula) from prescricao natural join consulta inner join instituicao
	on instituicao.nome = consulta.nome_instituicao
	WHERE data_consulta >= '2019-01-01' AND data_consulta < '2019-07-01'
	GROUP BY num_cedula, num_regiao) as foo
	NATURAL JOIN 
	(SELECT num_regiao, MAX(num_cedula) as num_prescricao from prescricao natural join consulta inner join instituicao
	on instituicao.nome = consulta.nome_instituicao
	WHERE data_consulta >= '2019-01-01' AND data_consulta < '2019-07-01'
	GROUP BY num_regiao) as bar;

-- 3
SELECT DISTINCT num_cedula FROM PrescricaoVenda p
WHERE NOT EXISTS (
    SELECT Instituicao.nome FROM Instituicao INNER JOIN Concelho
    ON Instituicao.num_concelho = Concelho.num_concelho
    WHERE Concelho.nome = 'Arouca' AND Instituicao.tipo = 'farmacia'

    EXCEPT

    SELECT DISTINCT Instituicao.nome FROM
    PrescricaoVenda NATURAL JOIN VendaFarmacia
    INNER JOIN Instituicao ON inst = Instituicao.nome
    WHERE substancia = 'Aspirina'
    AND p.num_cedula = PrescricaoVenda.num_cedula
    AND Instituicao.tipo = 'farmacia'
    AND EXTRACT(YEAR FROM PrescricaoVenda.data_consulta) = EXTRACT(YEAR from current_date)
);
--4

SELECT num_doente FROM Analise 
EXCEPT
(SELECT num_doente FROM PrescricaoVenda
WHERE EXTRACT(MONTH FROM data_consulta) = EXTRACT(MONTH from current_date)
AND EXTRACT(YEAR FROM data_consulta) = EXTRACT(YEAR from current_date));
