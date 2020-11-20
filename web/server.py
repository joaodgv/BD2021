from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index(name=None):
    return render_template('index.html', name=name)

@app.route('/inserirIM')
def inserirIM(name=None):
	return render_template('Inserir/inserirIM.html', name=name)

@app.route('/inserirPA')
def inserirPA(name=None):
	return render_template('Inserir/inserirIM.html', name=name)

@app.route('/api/inserir')
def inserir():
	return None

def searchQuery(query):
	# Function that searches the DB and returns the result of the query

	return None

if __name__ == '__main__':
   app.run()