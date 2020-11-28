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
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s".format(DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

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

# api routes
@app.route('/api/inserir', methods=['GET', 'POST'])
def inserir():
	inserir = request.args.get('inserir')

	data = request.args

	# TODO: Falta verificacao

	if inserir == 'inst':
		#handle inserir inst
		query = "INSERT INTO Instituicao VALUES ({},{},{},{});".format(data['nome'],data['tipo'],data['nRegiao'],data['nConcelho'])
	elif inserir == 'med':
		#handle inserir med
		query = "INSERT INTO Medico VALUES ({},{},{});".format(data['nCedula'],data['nome'],data['esp'])
	elif inserir == 'pres':
		#handle inserir pres
		query = "INSERT INTO Prescricao VALUES ({},{},{});".format(data['nCedula'],data['nome'],data['esp'])
	elif inserir == 'ana':
		#handle inserir ana
		query = "INSERT INTO Analise VALUES ({},{},{});".format(data['nCedula'],data['nome'],data['esp'])
	
	reply = searchQuery(query)

	return jsonify(True)

@app.route('/api/remover', methods=['GET', 'POST'])
def remover():
	remover = request.args.get('remover')

	data = request.args

	# TODO: falta verificacao

	if remover == 'inst':
		#handle remover inst
		query = "DELETE FROM Instituicao WHERE name = {};".format(data['nome'])
	elif remover == 'med':
		#handle remover med
		query = "DELETE FROM Medico WHERE nCedula = {}".format(data['nCedula'])
	elif remover == 'pres':
		#handle remover pres
		query = ""
	elif remover == 'ana':
		#handle remover ana
		query = ""
	return "true"

@app.route('/api/editar', methods=['GET', 'POST'])
def editar():
	editar = request.args.get('editar')

	data = request.args

	# TODO: falta verificacao

	if editar == 'inst':
		#handle editar inst
		query = "DELETE FROM Instituicao WHERE name = {};".format(data['nome'])
	elif editar == 'med':
		#handle editar med
		query = "DELETE FROM Medico WHERE nCedula = {}".format(data['nCedula'])
	elif editar == 'pres':
		#handle editar pres
		query = ""
	elif editar == 'ana':
		#handle editar ana
		query = ""

	return "true"

def searchQuery(query):
	# Function that searches the DB and returns the result of the query

	dbConn=None
	cursor=None
	try:
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
		cursor.execute(query)
	except Exception as e:
		return str(e) #Renders a page with the error.
	finally:
		cursor.close()
		dbConn.close()

	return True

if __name__ == '__main__':
   app.run()