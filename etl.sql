
CREATE OR REPLACE FUNCTION get_time() RETURNS VOID AS $$
    DECLARE
        data_consulta DATE;
    BEGIN
        SELECT data_consulta INTO data_consulta
        FROM Consulta;

        INSERT INTO d_tempo(dia, dia_da_semana, semana, mes, trimestre, ano) VALUES (EXTRACT(day from data_consulta), EXTRACT(DOW from data_consulta), EXTRACT(week from data_consulta), EXTRACT(month from data_consulta), EXTRACT(quarter from data_consulta), EXTRACT(year from data_consulta));
    END;
$$ language plpgsql;

INSERT INTO d_instituicao (nome, tipo, num_regiao, num_concelho)
SELECT nome, tipo, num_regiao, num_concelho
FROM Instituicao NATURAL JOIN Concelho NATURAL JOIN Regiao;

SELECT get_time();

INSERT INTO f_presc_venda (id_medico,  num_doente, id_data_registo, id_inst, substancia, quant)
SELECT (
    SELECT num_cedula
    FROM Medico NATURAL JOIN Prescricao
    WHERE Medico.num_cedula = Prescricao.num_cedula;
) AS id_medico, (
    SELECT num_doente
    FROM Consulta NATURAL JOIN Prescricao
    WHERE Consulta.num_cedula = Prescricao.id_medico AND Consulta.num_doente = Prescricao.num_doente AND Consulta.data_consulta = Prescricao.data_prescricao;
) AS num_doente, (
    SELECT id_data_registo
    FROM d_tempo
    WHERE EXTRACT(DAY FROM Prescricao.data_prescricao) = d_tempo.dia AND EXTRACT(MONTH FROM Prescricao.data_prescricao) = d_tempo.mes AND EXTRACT(YEAR FROM Prescricao.data_prescricao) = d_tempo.ano;
) AS id_data_registo, (
    SELECT id_inst
    FROM d_instituicao
    WHERE d_instituicao.id_inst = Prescricao.id_inst;
) AS id_inst (
    SELECT substancia
    FROM Consulta NATURAL JOIN Prescricao
    WHERE Consulta.num_cedula = Prescricao.id_medico AND Consulta.num_doente = Prescricao.num_doente AND Consulta.data_consulta = Prescricao.data_prescricao;
) AS substancia (
    SELECT quantidade
    FROM Consulta NATURAL JOIN Prescricao
    WHERE Consulta.num_cedula = Prescricao.id_medico AND Consulta.num_doente = Prescricao.num_doente AND Consulta.data_consulta = Prescricao.data_prescricao;
) AS quant
FROM Prescricao NATURAL JOIN Consulta NATURAL JOIN Medico; 

INSERT INTO f_analise (id_medico,  num_doente, id_data_registo, id_inst, quant)
SELECT (
    SELECT num_cedula
    FROM Medico NATURAL JOIN Analise
    WHERE Medico.num_cedula = Analise.num_cedula;
) AS id_medico, (
    SELECT num_doente
    FROM Consulta NATURAL JOIN Analise
    WHERE Consulta.num_cedula = Analise.id_medico AND Consulta.num_doente = Analise.num_doente AND Consulta.data_consulta = Analise.data_consulta;
) AS num_doente, (
    SELECT id_data_registo
    FROM d_tempo
    WHERE EXTRACT(DAY FROM Analise.data_consulta) = d_tempo.dia AND EXTRACT(MONTH FROM Prescricao.data_consulta) = d_tempo.mes AND EXTRACT(YEAR FROM Prescricao.data_consulta) = d_tempo.ano;
) AS id_data_registo, (
    SELECT id_inst
    FROM d_instituicao
    WHERE d_instituicao.id_inst = Analise.id_inst;
) AS id_inst (
    SELECT quantidade
    FROM Consulta NATURAL JOIN Analise
    WHERE Consulta.num_cedula = Analise.id_medico AND Consulta.num_doente = Analise.num_doente AND Consulta.data_consulta = Analise.data_prescricao;
) AS quant
FROM Analise NATURAL JOIN Consulta NATURAL JOIN Medico;