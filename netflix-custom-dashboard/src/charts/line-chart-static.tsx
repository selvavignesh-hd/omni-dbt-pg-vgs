import { VegaEmbed } from 'react-vega';

const lineChartSpec = {
    "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
    "data": {"url": "https://vega.github.io/editor/data/barley.json"},
    "mark": "bar",
    width: '1100',
    height: '200',
    "encoding": {
      "x": {"aggregate": "sum", "field": "yield"},
      "y": {"field": "variety"},
      "color": {"field": "site"}
    }
  }
const LineChartStatic = () => {
    
    return (
        <div>
            <h3>Line Chart Static</h3>
            <VegaEmbed spec={lineChartSpec} />
        </div>
    )
}

export default LineChartStatic;