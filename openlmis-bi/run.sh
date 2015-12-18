#!/usr/bin/env bash

function wait_for_postgres {
	until docker exec sd-postgres sh -c "psql -U postgres"
	do
	    echo "waiting for postgres container..."
	    sleep 0.5
	done && \
	echo "postgres is up"
}

docker rm -f sd-postgres
docker rm -f sd-cubes
docker rm -f sd-cubes-viewer

docker run --name sd-postgres -e POSTGRES_PASSWORD=mysecretpassword -d --volume=`pwd`:/work postgres && \
wait_for_postgres && \
docker exec sd-postgres sh -c "createuser -U postgres --superuser openlmis" && \
docker exec sd-postgres sh -c "createdb -U postgres openlmis" && \
wait_for_postgres && \
docker exec sd-postgres sh -c "psql -U openlmis -d openlmis -f /work/db_dump.sql" && \
\
docker run -d --link sd-postgres:sd-cubes --name sd-cubes --expose=5000 -p 5000:5000 --volume=`pwd`:/cubes h12w/cubes && \
\
docker run -d --link sd-cubes:sd-cubes-viewer --name sd-cubes-viewer -p 8000:8000 \
    --env=CUBES_HOST="http://`docker inspect -f '{{ .NetworkSettings.IPAddress }}' sd-cubes`:5000" \
    --env=ADMIN_PASS='mysecretpassword' h12w/cubes-viewer && \
\
echo && \
echo "Cubes Viewer is available at http://localhost:8000/cubesviewer/" && \
echo "If you are using a Mac, please make sure forwarding port 8000 from your docker host VM."