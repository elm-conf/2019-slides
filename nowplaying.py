#!/usr/bin/env python3
import http.server as http
import subprocess

def now_playing():
    scpt = open('nowPlaying.applescript', 'r').read()
    return subprocess.check_output([
        'osascript', '-e', scpt
    ])

class Handler(http.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(now_playing() + b'\n')

if __name__ == '__main__':
    addr = ('', 8000)
    httpd = http.HTTPServer(addr, Handler)
    httpd.serve_forever()
