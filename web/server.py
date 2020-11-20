from flask import Flask, render_template, jsonify, request
app = Flask(__name__)

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
	elif inserir == 'ana':
		#handle inserir ana
		
	return jsonify(True)

@app.route('/api/remover', methods=['GET', 'POST'])
def remover():
	inserir = request.args.get('remover')

	data = request.args

	# TODO: falta verificacao

	if inserir == 'inst':
		#handle inserir inst
		query = "DELETE FROM Instituicao WHERE name = {};".format(data['nome'])
	elif inserir == 'med':
		#handle inserir med
		query = "DELETE FROM Medico WHERE nCedula = {}".format(data['nCedula'])
	elif inserir == 'pres':
		#handle inserir pres
	elif inserir == 'ana':
		#handle inserir ana
	return "true"

@app.route('/api/editar', methods=['GET', 'POST'])
def editar():
	return "true"

def searchQuery(query):
	# Function that searches the DB and returns the result of the query

	return None

if __name__ == '__main__':
   app.run()