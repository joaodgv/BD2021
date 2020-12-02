INSERT INTO Regiao
VALUES (0, 'Centro', 1000000);

INSERT INTO Regiao
VALUES (1, 'Lisboa', 4000000);

INSERT INTO Regiao
VALUES (2, 'Norte', 4000000);

INSERT INTO Regiao
VALUES (3, 'Alentejo', 500000);

INSERT INTO Regiao
VALUES (4, 'Algarve', 500000);


INSERT INTO Concelho
VALUES (0, 0, 'Coimbra', 100000);

INSERT INTO Concelho
VALUES (1, 1, 'Lisboa', 1000000);

INSERT INTO Concelho
VALUES (2, 2, 'Arouca', 50000);

INSERT INTO Concelho
VALUES (3, 0, 'Obidos', 50000);

INSERT INTO Concelho
VALUES (4, 4, 'Faro', 120000);

INSERT INTO Concelho
VALUES (5, 3, 'Setubal', 120000);


INSERT INTO Instituicao
VALUES ('Wells', 'farmacia', 0, 0);

INSERT INTO Instituicao
VALUES ('Luz', 'farmacia', 1, 1);

INSERT INTO Instituicao
VALUES ('Sao Jeronimo', 'farmacia', 2, 2);

INSERT INTO Instituicao
VALUES ('Maristas', 'farmacia', 0, 3);

INSERT INTO Instituicao
VALUES ('Hospital Alentejano', 'hospital', 3, 4);

INSERT INTO Instituicao
VALUES ('Sao Joao', 'clinica', 4, 4);

INSERT INTO Instituicao
VALUES ('Hospital Arouca', 'hospital', 2, 2);

INSERT INTO Instituicao
VALUES ('Hospital Obidos', 'hospital', 0, 3);

INSERT INTO Instituicao
VALUES ('Hospital Algarve', 'hospital', 4, 4);

INSERT INTO Instituicao
VALUES ('Hospital Lisboa', 'hospital', 1, 1);


INSERT INTO Medico
VALUES (0, 'Pedro', 'oftalmologia');

INSERT INTO Medico
VALUES (1, 'Maria', 'dermatologia');

INSERT INTO Medico
VALUES (2, 'Joao', 'otorrinolaringologista');

INSERT INTO Medico
VALUES (3, 'Francisca', 'anatomia');

INSERT INTO Medico
VALUES (4, 'Ruben', 'cirurgia geral');

INSERT INTO Medico
VALUES (5, 'Fernanda', 'anestesiologia');

INSERT INTO Medico
VALUES (6, 'Mario', 'oftalmologia');

INSERT INTO Medico
VALUES (7, 'Jose', 'anatomia');

INSERT INTO Medico
VALUES (8, 'Joana', 'cirurgia geral');

INSERT INTO Medico
VALUES (9, 'Igor', 'dermatologia');

INSERT INTO Medico 
VALUES(10, 'Joaquim', 'oftalmologia');

INSERT INTO Consulta
VALUES (0, 0, '2019-01-01', 'Hospital Lisboa');

INSERT INTO Consulta
VALUES (0, 1, '2019-05-05', 'Hospital Alentejano');

INSERT INTO Consulta
VALUES (0, 20, '2019-02-05', 'Hospital Alentejano');

INSERT INTO Consulta
VALUES (1, 2, '2020-01-02', 'Hospital Alentejano');

INSERT INTO Consulta
VALUES (2, 3, '2020-01-03', 'Hospital Arouca');

INSERT INTO Consulta
VALUES (3, 4, '2020-02-07', 'Hospital Alentejano');

INSERT INTO Consulta
VALUES (4, 7, '2020-04-30', 'Hospital Algarve');

INSERT INTO Consulta
VALUES (4, 4, '2020-11-20', 'Hospital Algarve');

INSERT INTO Consulta
VALUES (5, 9, '2019-02-10', 'Hospital Obidos');

INSERT INTO Consulta
VALUES (6, 12, '2020-01-05', 'Hospital Alentejano');

INSERT INTO Consulta
VALUES (3, 18, '2020-02-09', 'Hospital Alentejano');

INSERT INTO consulta 
VALUES(10,20,'2019-1-1', 'Hospital Obidos');

INSERT INTO consulta 
VALUES(10,30,'2019-1-1', 'Hospital Obidos');

INSERT INTO Prescricao
VALUES (0, 0, '2019-01-01', 'Aspirina', 3);

INSERT INTO Prescricao
VALUES (0, 1, '2019-05-05', 'B', 2);

INSERT INTO Prescricao
VALUES (0, 20, '2019-02-05', 'B', 2);

INSERT INTO Prescricao
VALUES (1, 2, '2020-01-02', 'C', 5);

INSERT INTO Prescricao
VALUES (2, 3, '2020-01-03', 'Aspirina', 2);

INSERT INTO Prescricao
VALUES (3, 4, '2020-02-07', 'X', 5);

INSERT INTO Prescricao
VALUES (4, 7, '2020-04-30', 'D', 2);

INSERT INTO Prescricao
VALUES (4, 4, '2020-11-20', 'C', 2);

INSERT INTO Prescricao
VALUES (5, 9, '2019-02-10', 'Aspirina', 3);

INSERT INTO Prescricao
VALUES (6, 12, '2020-01-05', 'Y', 2);

INSERT INTO Prescricao 
VALUES(10,20,'2019-1-1', 'Aspirina',1);

INSERT INTO Prescricao 
VALUES(10,30,'2019-1-1', 'Aspirina',1);

INSERT INTO Analise
VALUES (0, 'oftalmologia', 0, 0, '2019-01-01', '2019-01-01', 'a', 3, 'Hospital Lisboa'); 

INSERT INTO Analise
VALUES (1, 'oftalmologia', 0, 1, '2019-05-05', '2019-05-05', 'b', 2, 'Hospital Lisboa');

INSERT INTO Analise
VALUES (2, 'otorrinolaringologista', 2, 3, '2020-01-03', '2020-01-03', 'c', 2, 'Hospital Arouca');

INSERT INTO Analise
VALUES (3, 'dermatologia', 1, 2, '2020-01-02', '2020-01-02', 'd', 5, 'Hospital Alentejano');

INSERT INTO Analise
VALUES (4, 'anatomia', 3, 4, '2020-02-07', '2020-02-07', 'e', 2, 'Hospital Alentejano');

INSERT INTO Analise
VALUES (5, 'cirurgia geral', 4, 7, '2020-04-30', '2020-04-30', 'f', 2, 'Hospital Algarve');


INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-11-20', 'Aspirina', 25, 5, 'Wells');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-01-01', 'B', 25, 10, 'Maristas');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-12-29', 'Aspirina', 35, 2, 'Sao Jeronimo');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-02-02', 'C', 12, 5, 'Luz');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-01-01', 'D', 13, 10, 'Sao Jeronimo');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-11-20', 'C', 4, 12, 'Hospital Algarve');

INSERT INTO VendaFarmacia
VALUES (DEFAULT, '2020-02-10', 'Aspirina', 3, 10, 'Maristas');

INSERT INTO PrescricaoVenda
VALUES (0, 0, '2019-01-01', 'Aspirina', 0);

INSERT INTO PrescricaoVenda
VALUES (5, 9, '2019-02-10', 'Aspirina', 6);

INSERT INTO PrescricaoVenda
VALUES (0, 1, '2019-05-05', 'B', 1);

INSERT INTO PrescricaoVenda
VALUES (2, 3, '2020-01-03', 'Aspirina', 2);

INSERT INTO PrescricaoVenda
VALUES (4, 4, '2020-11-20', 'C', 5);

INSERT INTO PrescricaoVenda
VALUES (4, 7, '2020-04-30', 'D', 4);