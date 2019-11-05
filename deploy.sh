docker build -t isurug/multi-client:latest -t isurug/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t isurug/multi-server:latest -t isurug/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t isurug/multi-worker:latest -t isurug/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push isurug/multi-client:latest
docker push isurug/multi-server:latest
docker push isurug/multi-worker:latest

docker push isurug/multi-client:$SHA
docker push isurug/multi-server:$SHA
docker push isurug/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=isurug/multi-server:$SHA
kubectl set image deployments/client-deployment client=isurug/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=isurug/multi-worker:$SHA