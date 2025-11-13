import React from 'react';
import { NetflixVegaDashboard } from './ntflx-vega-dashboard';
import 'bootstrap/dist/css/bootstrap.min.css';
import { ContentByCountry } from './charts/content-by-country';
import LineChartStatic from './charts/line-chart-static';

function App() {
  return (
    <div className="container">
      <div className="mb-3">
        <ContentByCountry />
      </div>
      <div className="mb-3">
        <LineChartStatic />
      </div>
      <div className="mb-3">
        <NetflixVegaDashboard />
      </div>
    </div>
  );
}

export default App;
