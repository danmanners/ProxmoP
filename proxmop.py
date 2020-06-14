## Imports
import requests
import json
from flask import Flask, session, redirect, url_for, escape, request, json
from datetime import timedelta

## Mandatory Flask App Name
app = Flask(__name__)

## Secrets Configuration
app.config['SECRET_KEY'] = b'notreal'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=30)

## Hardcoded Values
proxmoxurl = 'https://pmx.danmanners.io:8006/api2/'

## Session Check
def checksession():
	# Check that there's a live session and boot call to the error screen
	if 'authtoken' not in session:
		return error()

@app.route("/")
def index():
	if 'authtoken' in session:
		return '''
		Auth Token: ''' + escape(session['authtoken'])[:36] + '''<br>
		CSRF Token: ''' + escape(session['csrf'])
	return 'You are not authenticated.'

@app.route("/login", methods=['POST'])
def login():
	request.to_json()
	content = request.get_json()
	print(type(content))
	params = {
		'username': request.get_json('u'),
		'password': request.get_json('p'),
		'authback': request.get_json('a')
	}
	return content

	json = str("username=" + user + "@pam&password=" + pswd)

	loginurl = proxmoxurl + 'json/access/ticket'
	r = requests.post(loginurl, data=json)

	if r.json()['data'] == None:
		return error()
	else:
		authtoken = r.json()['data']['ticket']
		csrf = r.json()['data']['CSRFPreventionToken']
		session['authtoken'] = authtoken
		session['csrf'] = csrf
		return 'You have been logged in!'

@app.route("/list/nodes", methods=['GET'])
def listnodes():
	checksession()

	url = proxmoxurl + 'json/nodes'
	cookie = dict(PVEAuthCookie=session['authtoken'])
	r = requests.get(url, cookies=cookie)
	response = json.dumps(r.json(), sort_keys=True, indent=4, separators=(',',': ') )
	return response

@app.route("/create/qemu", methods=['POST'])
def create_qemu_vm(name,vmid,cores,memory,disksize,network,ipaddr,sshkey):
	checksession()

	url = proxmoxurl + '/'
	builddoc = {"name":str(name),
				"vmid":int(vmid),
				"cores":int(cores),
				"memory":int(memory*1024),
				"disksize":str(disksize + 'G'),
				"network":int(network),
				"ipaddr":str(ipaddr),
				"sshkeyloc":str(sshkey)}
	r = request.post(url, data=builddoc)
	if r.status == 200:
		return '{"success": True}'
	else:
		return '{"success": False}'

@app.route("/logout", methods=['GET'])
def logout():
	session.pop('authtoken', None)
	return redirect(url_for('index'))

## Error Handling
@app.route("/error")
def error():
	err = str("Whoops! Something went wrong! Please try again!")
	return err
