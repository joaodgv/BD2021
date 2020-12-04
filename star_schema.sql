DROP TABLE ON CASCADE d_tempo;
DROP TABLE ON CASCADE d_instituicao;
DROP TABLE ON CASCADE f_presc_venda;
DROP TABLE ON CASCADE f_analise;

CREATE TABLE d_tempo (
	id_tempo SERIAL NOT NULL DEFAULT PRIMARY KEY,
	dia INT NOT NULL,
	dia_da_semana VARCHAR(15) NOT NULL,
	semana INT NOT NULL,
	mes INT NOT NULL,
	trimestre INT NOT NULL,
	ano INT NOT NULL
);

CREATE TABLE d_instituicao(
	id_inst SERIAL NOT NULL DEFAULT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	num_regiao INT NOT NULL,
	num_concelho INT NOT NULL
);

CREATE TABLE f_presc_venda(
	id_presc_venda SERIAL NOT NULL DEFAULT PRIMARY KEY,
	id_medico INT NOT NULL,
	id_data_registo INT NOT NULL,
	id_inst INT NOT NULL,
	num_doente INT NOT NULL,
	substancia VARCHAR(25) NOT NULL,
	quantidade INT NOT NULL,
	FOREIGN KEY id_data_registo
		REFERENCES d_tempo (id_tempo),
	FOREIGN KEY id_inst
		REFERENCES d_instituicao (id_inst)
);

CREATE TABLE f_analise(
	id_analise SERIAL NOT NULL DEFAULT PRIMARY KEY,
	id_medico INT NOT NULL,
	id_data_registo INT NOT NULL,
	id_inst INT NOT NULL,
	num_doente INT NOT NULL,
	nome VARCHAR(25) NOT NULL,
	quant INT NOT NULL,
	FOREIGN KEY id_data_registo
		REFERENCES d_tempo (id_tempo),
	FOREIGN KEY id_inst
		REFERENCES d_instituicao (id_inst)
);