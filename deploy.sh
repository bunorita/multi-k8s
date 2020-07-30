docker build -t bunorita/multi-client:latest -t bunorita/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t bunorita/multi-server:latest -t bunorita/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bunorita/multi-worker:latest -t bunorita/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bunorita/multi-client:latest
docker push bunorita/multi-server:latest
docker push bunorita/multi-worker:latest

docker push bunorita/multi-client:$SHA
docker push bunorita/multi-server:$SHA
docker push bunorita/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bunorita/multi-server:$SHA
kubectl set image deployments/client-deployment client=bunorita/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bunorita/multi-workers:$SHA
