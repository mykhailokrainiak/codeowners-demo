const http = require("node:http");
http.createServer((q, s) => s.end("ok")).listen(3000);
