docker build -t jingjielim/multi-client:latest -t jingjielim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jingjielim/multi-server:latest -t jingjielim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jingjielim/multi-worker:latest -t jingjielim/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jingjielim/multi-client:latest
docker push jingjielim/multi-server:latest
docker push jingjielim/multi-worker:latest

docker push jingjielim/multi-client:$SHA
docker push jingjielim/multi-server:$SHA
docker push jingjielim/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jingjielim/multi-server:$SHA
kubectl set image deployments/client-deployment client=jingjielim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jingjielim/multi-worker:$SHA