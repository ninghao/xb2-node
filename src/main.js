const http = require('http');

const server = http.createServer((request, response) => {
  const data = {
    id: 1,
    title: '关山月',
    content: '明月出天山，苍茫云海间'
  }

  const jsonData = JSON.stringify(data);

  response.writeHead(200, {
    'Content-Type': 'application/json; charset=utf-8'
  });

  response.write(jsonData);

  response.end();
});

server.listen(3000, () => {
  console.log('🚀 服务已启动！');
});