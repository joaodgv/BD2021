1--
SELECT analise.especialidade, d_tempo.mes, d_tempo.ano, COUNT(id_analise) as quantidade_total
FROM f_analise
NATURAL JOIN analise
NATURAL JOIN d_tempo
WHERE d_tempo.ano>=2017 AND d_tempo.ano<=2020 AND f_analise.nome="Glicémia"
GROUP BY ROLLUP(d_tempo.mes, d_tempo.ano)
ORDER BY (mes,ano) ASC;


2--

SELECT d_instituicao.num_concelho, d_tempo.dia_da_semana, d_tempo.mes, f_presc_venda.substancia, SUM(id_presc_venda) as quantidade_total, AVG(id_presc_venda) as media_prescricoes_diarias
FROM f_presc_venda 
NATURAL JOIN d_tempo
NATURAL JOIN  d_instituicao
NATURAL JOIN Regiao
WHERE d_tempo.trimestre=1 AND d_tempo.ano=2020 AND Regiao.nome="Lisboa"
GROUP BY ROLLUP (d_tempo.dia_da_semana,d_tempo.mes), d_instituicao.num_concelho
ORDER BY (num_concelho, dia_da_semana,mes) DESC;
