# National Parks on k8's

After the [Habitat operator](https://github.com/habitat-sh/habitat-operator) is up and running,
execute the following command from the root of this repository:

```
kubectl create -f habitat-operator/habitat.yml
```

This will deploy the national parks app into your kubernetes cluster.

If you are running on GKE you can also expose the application with an external load balancer by:

```
kubectl create -f habitat-operator/gke-service.yml
```

The national parks app can be accessed at http://<ip>/national-parks
