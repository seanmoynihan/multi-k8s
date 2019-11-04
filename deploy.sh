docker build -t seanmoynihan/multi-client:latest -t seanmoynihan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t seanmoynihan/multi-server:latest -t seanmoynihan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t seanmoynihan/multi-worker:latest -t seanmoynihan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push seanmoynihan/multi-client:latest
docker push seanmoynihan/multi-server:latest
docker push seanmoynihan/multi-worker:latest

docker push seanmoynihan/multi-client:$SHA
docker push seanmoynihan/multi-server:$SHA
docker push seanmoynihan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=seanmoynihan/multi-server
kubectl set image deployments/client-deployment client=seanmoynihan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=seanmoynihan/multi-worker:$SHA