# Small Data Solution

## An Example: BI for [OpenLMIS](http://openlmis.org/)

Start the cluster in a docker console with [docker-compose](https://docs.docker.com/compose/) installed:

<code>cd openlmis-bi</code>

<code>docker-compose up</code>


Load OpenLMIS sample data in another docker console:

<code>cd openlmis-bi</code>

<code>./init-db.sh</code>

Now an interactive Web-based BI system should be running at [http://localhost:8000/cubesviewer/](http://localhost:8000/cubesviewer/). Login credentials are <code>admin/mysecretpassword</code>.
