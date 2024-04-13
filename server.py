from flask import Flask, render_template, request
from flask_mysqldb import MySQL
import pandas as pd

app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "usrs"

mysql = MySQL(app)

def runstatement(statement):
    cursor = mysql.connection.cursor()
    cursor.execute(statement)
    results = cursor.fetchall()
    mysql.connection.commit()
    df = ""
    if cursor.description:
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns = column_names)
    cursor.close()
    return df

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if 'login' in request.form:

            username = request.form['uname']
            password = request.form['pwd']
            df = runstatement(f"call checkUsr('{username}', '{password}')")

            return render_template("test.html", result=df[0])
        else:

            return render_template("login.html")
    else:
        return render_template("login.html")

@app.route("/test")
def test():
    return render_template("test.html", result=None)

@app.route("/registration")
def registration():
    return render_template("registration.html")

@app.route("/alias")
def alias():
    df = runstatement("SELECT * FROM alias")
    return render_template("alias.html", data=df.to_html())

@app.route("/appeals")
def appeals():
    df = runstatement("SELECT * FROM appeals")
    return render_template("appeals.html", data=df.to_html())

@app.route("/crime_charges")
def crime_charges():
    df = runstatement("SELECT * FROM crime_charges")
    return render_template("crime_charges.html", data=df.to_html())

@app.route("/crime_codes")
def crime_Codes():
    df = runstatement("SELECT * FROM crime_codes")
    return render_template("crime_codes.html", data=df.to_html())

@app.route("/crime_officers")
def crime_officers():
    df = runstatement("SELECT * FROM crime_officers")
    return render_template("crime_officers.html", data=df.to_html())

@app.route("/crimes")
def crimes():
    df = runstatement("SELECT * FROM crimes")
    return render_template("crimes.html", data=df.to_html())

@app.route("/criminals")
def criminals():
    df = runstatement("SELECT * FROM criminals")
    return render_template("criminals.html", data=df.to_html())

@app.route("/prob_officers")
def prob_officers():
    df = runstatement("SELECT * FROM prob_officers")
    return render_template("prob_officers.html", data=df.to_html())

@app.route("/officers")
def officers():
    df = runstatement("SELECT * FROM officers")
    return render_template("officers.html", data=df.to_html())

@app.route("/sentences")
def sentences():
    df = runstatement("SELECT * FROM sentences")
    return render_template("sentences.html", data=df.to_html())


if __name__ == "__main__":
    app.run(debug=True)