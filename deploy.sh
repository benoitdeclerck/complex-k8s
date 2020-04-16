docker build -t benoitdeclerck/multi-client:latest -t benoitdeclerck/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t benoitdeclerck/multi-server:latest -t benoitdeclerck/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t benoitdeclerck/multi-worker:latest -t benoitdeclerck/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push benoitdeclerck/multi-client:latest
docker push benoitdeclerck/multi-server:latest
docker push benoitdeclerck/multi-worker:latest
docker push benoitdeclerck/multi-client:$SHA
docker push benoitdeclerck/multi-server:$SHA
docker push benoitdeclerck/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=benoitdeclerck/multi-server:$SHA
kubectl set image deployments/client-deployment client=benoitdeclerck/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=benoitdeclerck/multi-worker:$SHA