-- RI - 100	
DROP TRIGGER IF EXISTS verifica_nconsultas_trigger ON consulta:
CREATE OR REPLACE FUNCTION verifica_nconsultas() RETURNS TRIGGER AS $$
BEGIN
    IF COUNT(t.Week) = 100
        FROM (
            SELECT WEEK(consulta.data_consulta) AS Week, YEAR(consulta.data_consulta) AS Year
            FROM consulta
            WHERE consulta.num_cedula = new.num_cedula AND consulta.nome_instituicao = new.nome_instituicao
                AND YEAR(consulta.data_consulta) = YEAR(new.data_consulta) AND WEEK(consulta.data_consulta) = WEEK(new.data_consulta)
            )
        AS t;
    THEN
        RAISE EXCEPTION 'Médico % já deu 100 consultas nesta semana de % na instituicao %', new.num_cedula, new.data_consulta, new.nome_instituicao;
    END IF;
    RETURN new;

END;
$$ Language plpgsql;
CREATE TRIGGER verifica_nconsultas_trigger BEFORE INSERT ON consulta
FOR EACH ROW EXECUTE PROCEDURE verifica_nconsultas();



-- RI - analise
DROP TRIGGER IF EXISTS verifica_especialidade_trigger ON analise;
CREATE OR REPLACE FUNCTION verifica_especialidade() RETURNS TRIGGER AS $$
BEGIN
    IF new.num_cedula <> null AND new.num_doente <> null AND new.data_consulta <> null AND new.especialidade <> (
        SELECT medico.especialidade
        FROM medico
        WHERE medico.num_cedula = new.num_cedula
    ) THEN
        RAISE EXCEPTION 'Análise % não tem especialidade correta', new.num_analise;
    END IF;
    RETURN new;

END;
$$ Language plpgsql;
CREATE TRIGGER verifica_especialidade_trigger BEFORE INSERT ON analise
FOR EACH ROW EXECUTE PROCEDURE verifica_especialidade();