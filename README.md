# Small Data Solution

## An Example: BI for [OpenLMIS](http://openlmis.org/)

Start the cluster in a docker console with [docker-compose](https://docs.docker.com/compose/) installed:

```
cd openlmis-bi
docker-compose up
```

Load OpenLMIS sample data in another docker console:

```
cd openlmis-bi
./init-db.sh
```

Now an interactive Web-based BI system should be running at [http://localhost:8000/cubesviewer/](http://localhost:8000/cubesviewer/). Login credentials are <code>admin/mysecretpassword</code>.

Once logged in, you can click "Add view from JSON" link on the left side, copy & paste following JSON in the popup dialog:

```
{
    "cubename": "requisition_line_items",
    "name": "ABC Stock In Hand",
    "mode": "chart",
    "drilldown": ["products:products"],
    "cuts": [{
        "dimension": "products",
        "value": "MMIA,08S01;MMIA,08S01B;MMIA,08S01ZZ"
    },{
        "dimension": "facilities",
        "value": "1;7;10"
    }],
    "datefilters": [],
    "rangefilters": [],
    "xaxis": "facilities",
    "yaxis": "stockinhand_sum",
    "charttype": "bars-vertical",
    "columnHide": {},
    "columnWidths": {},
    "columnSort": {}
}
```

Hit "OK", then you should see the following chart:

<img src='http://gigix.thoughtworkers.org/assets/2015/12/23/cubes-chart.png'/>