docker build -t kornvollis/multi-client:latest -t kornvollis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kornvollis/multi-server:latest -t kornvollis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kornvollis/multi-worker:latest -t kornvollis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kornvollis/multi-client:latest
docker push kornvollis/multi-server:latest
docker push kornvollis/multi-worker:latest

docker push kornvollis/multi-client:$SHA
docker push kornvollis/multi-server:$SHA
docker push kornvollis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kornvollis/multi-server:$SHA
kubectl set image deployments/client-deployment client=kornvollis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kornvollis/multi-worker:$SHA