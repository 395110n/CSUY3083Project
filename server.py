from flask import Flask, render_template, request
from flask_mysqldb import MySQL
import pandas as pd
app = Flask(__name__)
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "usrs"

def runstatement(statement):
    
    mysql = MySQL(app)
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

@app.route("/Alias")
def Alias():
    return render_template("alias.html")

@app.route("/Appeals")
def Appeals():
    return render_template("appeals.html")

@app.route("/Criminal_Charges")
def Criminal_Charges():
    return render_template("crime_charges.html")

@app.route("/Crime_Codes")
def Crime_Codes():
    return render_template("crime_codes.html")

@app.route("/Crime_officers")
def Crime_officers():
    return render_template("crime_officers.html")

@app.route("/Crimes")
def Crimes():
    return render_template("crimes.html")

@app.route("/Criminals")
def Criminals():
    return render_template("criminals.html")

@app.route("/Prob_officers")
def Prob_officers():
    return render_template("prob_officers.html")

@app.route("/Officers")
def Officers():
    return render_template("officers.html")

@app.route("/Sentences")
def Sentences():
    return render_template("sentences.html")


if __name__ == "__main__":
    app.run(debug=True)

