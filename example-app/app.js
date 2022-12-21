const http = require('http');
const os = require('os');

const hostname = '0.0.0.0';
const port = 8080;

const server = http.createServer((req, res) => {
  console.log(`Received request from ${req.socket.remoteAddress}`);
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end(`You've hit ${os.hostname()} from ${req.socket.remoteAddress}\n`);
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
