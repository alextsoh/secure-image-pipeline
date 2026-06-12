const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ message: 'hello from the secure pipeline demo app' });
});

app.get('/quote', async (req, res) => {
  try {
    const response = await axios.get('https://api.quotable.io/random');
    res.json(response.data);
  } catch (err) {
    res.status(500).json({ error: 'failed to fetch quote' });
  }
});

app.get('/health', (req, res) => {
  res.status(200).send('ok');
});

app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
});