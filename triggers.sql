-- Trigger 1
-- DROP TRIGGER IF EXISTS verifica_especialidade_trigger ON analise;
CREATE OR REPLACE FUNCTION verify_nconsultas() TRIGGER AS $$
BEGIN
	SELECT DATEPART(week, data) AS week, consulta.nome_instituicao
	FROM consulta
	WHERE MIN(consulta.data_consulta) <= data <= MAX(consulta.data_consulta)
	GROUP BY DATEPART(week, data);
END;
$$ Language plpgsql;
CREATE TRIGGER verifica_especialidade_trigger BEFORE INSERT ON consulta
FOR EACH ROW EXECUTE PROCEDURE verify_nconsultas();

-- Trigger 2
-- DROP TRIGGER IF EXISTS verifica_especialidade_trigger ON analise;
CREATE OR REPLACE FUNCTION verifica_especialidade() RETURNS TRIGGER AS $$
BEGIN
	IF NEW.num_cedula <> null AND NEW.num_doente <> null AND NEW.data_consulta <> null AND NEW.num_cedula <> (
		SELECT medico.especialidade
		FROM medico
		WHERE medico.num_cedula = NEW.num_cedula
	) THEN
		RAISE EXCEPTION 'Análise % não tem especialidade correta', NEW.num_analise;
	END IF;
END;
$$ Language plpgsql;
CREATE TRIGGER verifica_especialidade_trigger BEFORE INSERT ON analise
FOR EACH ROW EXECUTE PROCEDURE verifica_especialidade();