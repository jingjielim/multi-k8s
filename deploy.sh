docker build -t jingjielim/multi-client:latest -t jingjielim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jingjielim/multi-server:latest -t jingjielim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jingjielim/multi-worker:latest -t jingjielim/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jingjielim/multi-client
docker push jingjielim/multi-server
docker push jingjielim/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jingjielim/multi-server  