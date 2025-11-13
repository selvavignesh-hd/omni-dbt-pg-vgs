const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;
const API_HOST = 'https://partnerharkendata.omniapp.co/';

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

async function proxyRequest(req, res) {
  try {
    const endpoint = req.path;
    const targetUrl = `${API_HOST}${endpoint.replace(/^\//, '')}`;
    console.log('targetUrl :>> ', targetUrl);
    
    // Prepare request configuration
    const config = {
      method: req.method,
      url: targetUrl,
      params: req.query,
      data: req.body,
      headers: {
        ...req.headers,
        host: undefined,
        'content-length': undefined,
      },
    };

    const response = await axios(config);
    res.status(response.status);
    res.set(response.headers);
    res.send(response.data);
  } catch (error) {
    if (error.response) {
      res.status(error.response.status);
      res.set(error.response.headers);
      res.send(error.response.data);
    } else if (error.request) {
      res.status(502).json({
        error: 'Bad Gateway',
        message: 'No response received from the target server',
      });
    } else {
      res.status(500).json({
        error: 'Internal Server Error',
        message: error.message,
      });
    }
  }
}

app.all('*', proxyRequest);

app.listen(PORT, () => {
  console.log(`Proxy server running on http://localhost:${PORT}`);
  console.log(`Proxying requests to: ${API_HOST}`);
});
