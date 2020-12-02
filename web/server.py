#!/usr/bin/python3
from wsgiref.handlers import CGIHandler
from flask import Flask, render_template, jsonify, request

## Libs postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist190733"
DB_DATABASE=DB_USER
DB_PASSWORD="rmzx3978"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

@app.route('/')
def index(name=None):
    return render_template('index.html', name=name)

# Routes for add
@app.route('/inserirIM')
def inserirIM(name=None):
	return render_template('Inserir/inserirIM.html', name=name)

@app.route('/inserirPA')
def inserirPA(name=None):
	return render_template('Inserir/inserirPA.html', name=name)

# Routes for edit
@app.route('/editarIM')
def editarIM(name=None):
	return render_template('Inserir/editarIM.html', name=name)

@app.route('/editarPA')
def editarPA(name=None):
	return render_template('Inserir/editarPA.html', name=name)

#  Routes for remove
@app.route('/removerIM')
def removerIM(name=None):
	return render_template('Remover/removerIM.html', name=name)


@app.route('/removerPA')
def removerPA(name=None):
	return render_template('Remover/removerPA.html', name=name)

@app.route('/realizar')
def realizar(name=None):
	return render_template('Inserir/realizar.html', name=name)

# api routes
@app.route('/api/inserir', methods=['POST'])
def inserir(name=None):
	inserir = request.form["inserir"]

	# EXTRA WORK
	#if any(x in (';','--', '#') for entry in request.form):
	#	return render_template('Reply/error.html', name=name)

	if inserir == 'inst':
		#handle inserir inst
		query = "INSERT INTO Instituicao VALUES ('%s','%s',%s,%s);" % (request.form["nome"],request.form["tipo"],request.form["nRegiao"],request.form["nConcelho"])
	elif inserir == 'med':
		#handle inserir med
		query = "INSERT INTO Medico VALUES (%s,'%s','%s');" % (request.form["nCedula"],request.form["nome"],request.form["esp"])
	elif inserir == 'pres':
		#handle inserir pres
		query = "INSERT INTO Prescricao VALUES (%s,%s,'%s','%s',%s);" % (request.form["nCedula"],request.form["nDoente"],request.form["data"],request.form["subs"],request.form["qtd"])
	elif inserir == 'ana':
		#handle inserir ana
		query = "INSERT INTO Analise VALUES (%s,'%s',%s,%s,'%s','%s','%s',%s,'%s');" % (request.form["esp"],request.form["nCedula"],request.form["nDoente"],request.form["dConsulta"],request.form["dRegisto"],request.form["nome"],request.form["qtd"],request.form["inst"])
	
	reply = searchQuery(query)
	
	if editar=='med' or editar=='inst':
		return render_template('Inserir/inserirIM.html')

	return render_template('Inserir/inserirPA.html')

@app.route('/api/remover', methods=['GET', 'POST'])
def remover():
	remover = request.form['remover']

	if remover == 'inst':
		#handle remover inst
		query = "DELETE FROM Instituicao WHERE name = '%s';" % (request.form['nome'])
	elif remover == 'med':
		#handle remover med
		query = "DELETE FROM Medico WHERE num_cedula = %s;" % (request.form['nCedula'])
	elif remover == 'pres':
		#handle remover pres
		query = "DELETE FROM Prescricao WHERE num_cedula = %s AND num_doente = %s AND data_consulta='%s' AND substancia='%s';" % (request.form["nCedula"],request.form["nDoente"],request.form["data"],request.form["subs"])
	elif remover == 'ana':
		#handle remover ana
		query = "DELETE FROM Analise WHERE num_analise=%s;" % (request.form["nAnalise"])

	if editar=='med' or editar=='inst':
		return render_template('Remover/removerIM.html')

	return render_template('Remover/removerPA.html')

@app.route('/api/editar', methods=['GET', 'POST'])
def editar(name=None):
	editar = request.form['editar']

	if editar == 'inst':
		#handle editar inst
		query = "UPDATE Instituicao SET "
		if request.form["tipo"] != '':
			query += "tipo = '%s' " % request.form["tipo"]
		if request.form["nRegiao"] != '':
			query += "num_regiao = %s " % request.form["nRegiao"]
		if request.form["nConcelho"] != '':
			query += "num_concelho = %s " % request.form["nConcelho"]

		query += "WHERE nome='%s';" % request.form["nome"]

	elif editar == 'med':
		#handle editar med
		query = "UPDATE Medico SET "
		if request.form["nome"] != '':
			query += "nome = '%s' " % request.form["nome"]
		if request.form["esp"] != '':
			query += "especialidade = '%s' " % request.form["esp"]

		query += "WHERE num_cedula=%s;" % request.form["nCedula"]

	elif editar == 'pres':
		#handle editar pres
		query = "UPDATE Prescricao SET "
		if request.form["qtd"] != '':
			query += "quantidade = %s " % request.form["qtd"]
			query += "WHERE num_cedula=%s;" % request.form["nCedula"]
		else:
			return render_template('Erro.html')

	elif editar == 'ana':
		#handle editar ana
		query = "UPDATE Analise SET "
		if request.form["esp"] != '':
			query += "especialidade = '%s' " % request.form["esp"]
		if request.form["nCedula"] != '':
			query += "num_cedula = %s " % request.form["nCedula"]
		if request.form["nDoente"] != '':
			query += "num_doente = %s " % request.form["nDoente"]
		if request.form["dConsulta"] != '':
			query += "data_consulta = '%s' " % request.form["dConsulta"]
		if request.form["dRegisto"] != '':
			query += "data_registo = '%s' " % request.form["dRegisto"]
		if request.form["nome"] != '':
			query += "nome = '%s' " % request.form["nome"]
		if request.form["qtd"] != '':
			query += "quantidade = '%s' " % request.form["qtd"]
		if request.form["inst"] != '':
			query += "instituicao = '%s' " % request.form["inst"]

		query += "WHERE num_analise=%s;" % request.form["nAnalise"]

	if editar=='med' or editar=='inst':
		return render_template('Editar/editarIM.html')

	return render_template('Editar/editarPA.html')

@app.route('/api/realizar', methods=['GET', 'POST'])
def realizarAPI(name=None):
	pres = request.form["realizar"]

	print(request.form)

	if (pres=="com" and (request.form["subs"] != request.form["subs2"] or request.form["qtd"] != request.form["qtd2"])):
		return render_template('Reply/erro.html')
	elif (pres == 'com'):
		#do both queries
		query1 = "INSERT INTO Prescricao VALUES (%s,%s,'%s','%s',%s);" % (request.form["nCedula"],request.form["nDoente"], request.form["dataP"],request.form["subs2"],request.form["qtd2"])
		query2 = "INSERT INTO VendaFarmacia VALUES ('%s','%s',%s,%s,'%s');" % (request.form["dataR"],request.form["subs"],request.form["qtd"],request.form["preco"],request.form["inst"])
		query3 = "SELECT num_venda FROM VendaFarmacia ORDER BY num_venda DESC LIMIT 1;"
		
		searchQuery(query1)
		searchQuery(query2)
		reply = searchQuery(query3)

		query4 = "INSERT INTO VendaPrescricao VALUES (%s);" % ('hi')
		searchQuery(query4)
		
	else:
		#only sell pharmacy
		query1 = "INSERT INTO VendaFarmacia VALUES ('%s','%s',%s,%s,'%s');" % (request.form["dataR"],request.form["subs"],request.form["qtd"],request.form["preco"],request.form["inst"])

	return render_template('Inserir/realizar.html')

def searchQuery(query):
	# Function that searches the DB and returns the result of the query
	dbConn=None
	cursor=None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		cursor.execute(query)
		dbConn.commit()
	except Exception as e:
		return str(e) #Renders a page with the error.
	finally:
		cursor.close()
		dbConn.close()

	return cursor

#CGIHandler().run(app)

# Local test
if __name__ == "__main__":
    app.run(debug=True)