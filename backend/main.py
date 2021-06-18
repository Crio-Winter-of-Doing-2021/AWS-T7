from flask import Flask,render_template,request,jsonify
from wit import Wit

def extractor(resp):
    test=resp["entities"]
    if "greet" in test.keys():
        return(test["greet"][0]["value"]+". Welcome to Snapdeal.")
    elif "greet2" in test.keys():
        return(test["greet2"][0]["value"].title()+". Thanks for coming.")
    elif "none" in test.keys():
        return(test["none"][0]["value"])
    elif "faq17" in test.keys():
        return(test["faq17"][0]["value"])
    elif "faq16" in test.keys():
        return(test["faq16"][0]["value"])
    elif "faq15" in test.keys():
        return(test["faq15"][0]["value"])
    elif "faq14" in test.keys():
        return(test["faq14"][0]["value"])
    elif "faq13" in test.keys():
        return(test["faq13"][0]["value"])
    elif "faq12" in test.keys():
        return(test["faq12"][0]["value"])
    elif "faq11" in test.keys():
        return(test["faq11"][0]["value"])
    elif "faq10" in test.keys():
        return(test["faq10"][0]["value"])
    elif "faq9" in test.keys():
        return(test["faq9"][0]["value"])
    elif "faq8" in test.keys():
        return(test["faq8"][0]["value"])
    elif "faq7" in test.keys():
        return(test["faq7"][0]["value"])
    elif "faq6" in test.keys():
        return(test["faq6"][0]["value"])
    elif "faq5" in test.keys():
        return(test["faq5"][0]["value"])
    elif "faq4" in test.keys():
        return(test["faq4"][0]["value"])
    elif "faq3" in test.keys():
        return(test["faq3"][0]["value"])
    elif "faq2" in test.keys():
        return(test["faq2"][0]["value"])
    elif "faq1" in test.keys():
        return(test["faq1"][0]["value"])
    else:
        return("Sorry i did not understand what u meant.")

app = Flask(__name__)
client = Wit("47GEFJI3BDU4R5R6AFWNORTIYIIGSVLP")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/get")
def get_bot_response():
    try:
        userText=request.args.get("msg")
        resp = client.message(userText)
        t=extractor(resp)
        return str(t)
    except Exception as e:
        return e

if __name__=="__main__":
    app.run(debug=True)