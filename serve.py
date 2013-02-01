# Don't forget to generate your keys first!
# openssl req -new -x509 -keyout server.key -out server.crt -days 365 -nodes

import BaseHTTPServer, SimpleHTTPServer
import ssl

web_server = BaseHTTPServer.HTTPServer(('localhost', 8443), SimpleHTTPServer.SimpleHTTPRequestHandler)
web_server.socket = ssl.wrap_socket (web_server.socket, server_side=True, certfile="server.crt", keyfile="server.key")
print "Serving assets at https://localhost:8443/"
web_server.serve_forever()
