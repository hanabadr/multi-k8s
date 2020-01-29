docker build -t hanaabadr/multi-client:latest -t hanaabadr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hanaabadr/multi-server:latest -t hanaabadr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hanaabadr/multi-worker:latest -t hanaabadr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hanaabadr/multi-client:latest
docker push hanaabadr/multi-server:latest 
docker push hanaabadr/multi-worker:latest  

docker push hanaabadr/multi-client:$SHA
docker push hanaabadr/multi-server:$SHA 
docker push hanaabadr/multi-worker:$SHA  

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=hanaabadr/multi-client:$SHA
kubectl set image deployments/server-deployment server=hanaabadr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hanaabadr/multi-worker:$SHA 
