CREATE TABLE Regiao(
	num_regiao serial PRIMARY KEY,
	nome VARCHAR (20) NOT NULL,
	num_habitantes INT NOT NULL
);

CREATE TABLE Concelho(
	num_concelho serial,
	num_regiao INT NOT NULL,
	nome VARCHAR (50) NOT NULL,
	num_habitantes INT NOT NULL,
	PRIMARY KEY (num_concelho, num_regiao),
	FOREIGN KEY (num_regiao)
		REFERENCES Regiao (num_regiao)
);

CREATE TABLE Instituicao(
	nome VARCHAR (100) UNIQUE NOT NULL PRIMARY KEY,
	tipo VARCHAR (50) NOT NULL,
	num_regiao INT NOT NULL,
	num_concelho INT NOT NULL,
	FOREIGN KEY (num_regiao)
		REFERENCES Regiao (num_regiao),
	FOREIGN KEY (num_concelho)
		REFERENCES Concelho (num_concelho)
);

CREATE TABLE Medico(
	num_cedula INT PRIMARY KEY,
	nome VARCHAR (50) NOT NULL,
	especialidade VARCHAR (50) NOT NULL
);

CREATE TABLE Consulta(
	num_cedula INT NOT NULL,
	num_doente INT NOT NULL,
	data_consulta DATE NOT NULL,
	nome_instituicao CHAR (50) NOT NULL,
	PRIMARY KEY (num_cedula, num_doente, data_consulta),
	FOREIGN KEY (num_cedula)
		REFERENCES Medico (num_cedula),
	FOREIGN KEY (nome_instituicao)
		REFERENCES Instituicao (nome),
);

CREATE TABLE Prescricao(
	num_cedula INT NOT NULL,
	num_doente INT NOT NULL,
	data_prescricao DATE NOT NULL,
	substancia VARCHAR (50) NOT NULL,
	quantidade INT NOT NULL,
	PRIMARY KEY (num_cedula, num_doente, data_prescricao, substancia),
	FOREIGN KEY (num_cedula, num_doente, data_prescricao)
		REFERENCES Consulta (num_cedula, num_doente, data_consulta)
);

CREATE TABLE Analise(
	num_analise serial PRIMARY KEY,
	especialidade VARCHAR (50),
	num_cedula INT NOT NULL,
	num_doente INT NOT NULL,
	data_consulta DATE,
	data_registo DATE NOT NULL,
	nome VARCHAR (50) NOT NULL,
	quantidade INT NOT NULL,
	inst VARCHAR (50) NOT NULL,
	FOREIGN KEY (num_cedula, num_doente, data_consulta)
		REFERENCES Consulta(num_cedula, num_doente, data_consulta),
	FOREIGN KEY (inst)
		REFERENCES Instituicao(nome),
);

CREATE TABLE VendaFarmacia(
	num_venda serial PRIMARY KEY,
	data_registo DATE NOT NULL,
	substancia VARCHAR (50) NOT NULL,
	quantidade INT NOT NULL,
	preco REAL NOT NULL,
	inst VARCHAR (50) NOT NULL,
	FOREIGN KEY (inst)
		REFERENCES Instituicao(nome)
);

CREATE TABLE PrescricaoVenda(
	num_cedula INT NOT NULL,
	num_doente INT NOT NULL,
	data_consulta DATE,
	substancia VARCHAR (50) NOT NULL,
	num_venda INT NOT NULL,
	PRIMARY KEY (num_cedula, num_doente, data_consulta, substancia, num_venda)
	FOREIGN KEY (num_venda)
		REFERENCES VendaFarmacia(num_venda),
	FOREIGN KEY 
);