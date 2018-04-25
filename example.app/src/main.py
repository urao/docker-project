#!/usr/bin/python

from flask import Flask
import os


app = Flask(__name__, static_url_path='')

@app.route("/")
def index():
    html_header = '''<html>\n
    <head><title>Hello World!</title></head>\n
    <body>\n'''

    body_html = '''
    <h2>Hello World!</h2>\n
    <p>
    These are the environment variables your app has:\n

    <table border=1>\n
    '''
    table_html = ""
    for k, v in os.environ.iteritems():
        table_html += '''<tr><td>%s</td><td>%s</td></tr>\n''' % (k,v)

    table_html += '</table>\n'
    body_html += table_html
    close_html = '</body>\n</html>\n'
    html = html_header + body_html + close_html
    return html


def main():
    app.debug = True
    app.run(host='0.0.0.0', port=80)


if __name__ == '__main__':
    main()
