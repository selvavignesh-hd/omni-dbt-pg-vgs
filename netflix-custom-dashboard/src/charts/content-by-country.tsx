import { useEffect, useState } from "react";
import { VegaEmbed } from "react-vega";
import { getQueryResponse } from "../http-service";
import { OMNI_NFLX_MODEL_ID, OMNI_SCHEMA_NAME } from "../constants";

export const ContentByCountry = () => {

    const [countryDataSpec, setCountryDataSpec] = useState<any>(
        {
            "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
            "data": { values: [] },
            title: 'Content By Country',
            "mark": {
                type: "bar",
                tooltip: true,
            },
            "encoding": {
                "y": { "aggregate": "sum", "field": "Total Content" },
                "x": { "field": "Country", orient: 'horizontal' },
                "color": { "field": "Country" }
            }
        }
    );

    useEffect(() => {
        getQueryResponse(
            {
                "query": {
                    "limit": 100,
                    "sorts": [
                        {
                            "column_name": "omni_dbt_netflix_analytics__content_by_country.total_content",
                            "sort_descending": true
                        }
                    ],
                    "table": `${OMNI_SCHEMA_NAME}content_by_country`,
                    "modelId": OMNI_NFLX_MODEL_ID,
                    "fields": [
                        "country",
                        "total_content",
                        "unique_titles",
                        "movies_count",
                        "tv_shows_count"
                    ],
                },
                "cache": "SkipRequery",
                "resultType": "json"
            }
        ).then((data) => {
            console.log('data :>> ', data);
            // sample data
            // data[0] =  {
            //     "Country": "Bulgaria",
            //     "Total Content": 10,
            //     "Unique Titles": 10,
            //     "Movies Count": 10,
            //     "Tv Shows Count": "0"
            // };
            setCountryDataSpec({
                ...countryDataSpec,
                data: { values: data }
            });
            // setContentByCountryData(data);
        });
    }, []);


    return (
        <div>
            <h3>Content By Country</h3>
            <VegaEmbed spec={countryDataSpec} />
        </div>

    )
}

export default ContentByCountry;