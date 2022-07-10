docker build -t jet090892/multi-client:latest -t jet090892/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jet090892/multi-server:latest -t jet090892/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jet090892/multi-worker:latest -t jet090892/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jet090892/multi-client:latest
docker push jet090892/multi-server:latest
docker push jet090892/multi-worker:latest

docker push jet090892/multi-client:$SHA
docker push jet090892/multi-server:$SHA
docker push jet090892/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=jet090892/multi-server:$SHA
kubectl set image deployment/client-deployment client=jet090892/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=jet090892/multi-worker:$SHA
