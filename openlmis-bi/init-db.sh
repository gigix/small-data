#!/usr/bin/env bash

docker exec sd-postgres createuser -U postgres --superuser openlmis && \
docker exec sd-postgres createdb -U postgres openlmis && \
docker exec sd-postgres psql -U openlmis -d openlmis -f /work/db_dump.sql && \
echo && \
echo "OpenLMIS database is loaded" && \
echo "Cubes Viewer is available at http://localhost:8000/cubesviewer/" && \
echo "If you are using a Mac, please make sure forwarding port 8000 from your docker host VM."
