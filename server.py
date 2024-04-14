from flask import Flask, render_template, request, session, redirect, url_for
from flask_mysqldb import MySQL
import pandas as pd

app = Flask(__name__)
app.secret_key = "04/13/2024"

app.config["MYSQL_UNIX_SOCKET"] = "/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock"
# look in the XAMPP config file and see if the mysql.sock file has the address /temp/mysql.sock
# if not, you have to modify it
app.config["MYSQL_DB"] = "Usrs"
mysql = MySQL(app)

viewer = {
    "Alias": "*",
    "Criminals": ["Criminal_ID", "FirstName", 'LastName', 'V_status', 'P_status'],
    'Crimes': '*',
    'Sentences': '*',
    'Prob_officers': ['Prob_ID', 'FirstName', 'LastName', 'Status'],
    'Crime_charges': "*", 
    'Crime_officers': "*",
    'Officers': ['Officer_ID', 'FirstName', 'LastName', 'Precinct', 'Badge', 'Status'], 
    'Appeals': "*",
    'Crime_codes': '*'
}

'''
viewer previleges: 
GRANT SELECT ON Alias TO viewer;
GRANT SELECT (Criminal_ID, FirstName, LastName, V_status, P_status) ON Criminals TO viewer;
GRANT SELECT ON Crimes TO viewer;
GRANT SELECT ON Sentences TO viewer;
GRANT SELECT (Prob_ID, FirstName, LastName, Status) ON Prob_officers TO viewer;
GRANT SELECT ON Crime_charges TO viewer;
GRANT SELECT ON Crime_officers TO viewer;
GRANT SELECT (Officer_ID, FirstName, LastName, Precinct, Badge, Status) ON Officers TO viewer;
GRANT SELECT ON Appeals TO viewer;
GRANT SELECT ON Crime_codes TO viewer;
'''

def runstatement(statement, commit=False):
    cursor = mysql.connection.cursor()
    cursor.execute(statement)
    results = cursor.fetchall()
    if commit:
        mysql.connection.commit()
    df = ""
    if cursor.description:
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns = column_names)
    cursor.close()
    return df

def generateStatementViewer(table, action, query, attr="*"):
    if isinstance(attr, list):
        attr = ", ".join(attr)
    
    if action.lower() != "select":
        return pd.DataFrame()
    sql = f"{action.upper()} {attr.upper()} FROM {table.upper()}"
    if query:
        sql += f"WHERE {query}"
    return sql

@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'username' in session:
        return redirect(url_for('profile', username=session['username']))
    if request.method == 'POST':
        if 'login' in request.form:
            username = request.form['uname']
            password = request.form['pwd']
            df = runstatement(f'''call checkUsr('{username}', '{password}')''')
            if df.iloc[0, 0] != 0:
                session["username"] = username
                session["firstName"] = df.iloc[0, 2]
                session["lastName"] = df.iloc[0, 3]
                session["permission"] = df.iloc[0, 4]

                return redirect(url_for('profile', username=username))
    return render_template("login.html")


@app.route("/<username>/profile")
def profile(username):
    return render_template("profile.html", 
                    username=username, 
                    firstname=session.get("firstName"), 
                    lastname=session.get("lastName"))


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route("/registration")
def registration():
    return render_template("registration.html")

@app.route("/<username>/alias")
def alias(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer("Alias", "select", None, viewer["Alias"]))
    return render_template("alias.html", data=df.to_html())

@app.route("/<username>/appeals")
def appeals(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer("Appeals", 'select', None, viewer["Appeals"]))
    return render_template("appeals.html", data=df.to_html())

@app.route("/<username>/crime_charges")
def crime_charges(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer("Crime_charges", 'select', None, viewer["Crime_charges"]))
    return render_template("crime_charges.html", data=df.to_html())

@app.route("/<username>/crime_codes")
def crime_codes(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Crime_codes', 'select', None, viewer["Crime_codes"]))
    return render_template("crime_codes.html", data=df.to_html())

@app.route("/<username>/crime_officers")
def crime_officers(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Crime_officers', 'select', None, viewer['Crime_officers']))
    return render_template("crime_officers.html", data=df.to_html())

@app.route("/<username>/crimes")
def crimes(username):
    
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Crimes', 'select', None, viewer['Crimes']))
    return render_template("crimes.html", data=df.to_html())

@app.route("/<username>/criminals")
def criminals(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Criminals', 'select', None, viewer['Criminals']))
    return render_template("criminals.html", data=df.to_html())

@app.route("/<username>/prob_officers")
def prob_officers(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Prob_officers', 'select', None, viewer["Prob_officers"]))
    return render_template("prob_officers.html", data=df.to_html())

@app.route("/<username>/officers")
def officers(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Officers', 'select', None, viewer['Officers']))
    return render_template("officers.html", data=df.to_html())

@app.route("/<username>/sentences")
def sentences(username):
    runstatement('''use Criminal_Records''', commit=True)
    df = runstatement(generateStatementViewer('Sentences', 'select', None, viewer['Sentences']))
    return render_template("sentences.html", data=df.to_html())


if __name__ == "__main__":
    app.run(debug=True)