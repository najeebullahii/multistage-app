const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({ message: 'Multi-stage build!' });
});

module.exports = app;
