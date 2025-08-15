# k8s-helm-chart-tutorial
Leer spelen met containers op Kubernetes met Docker, Helm Charts en prestatie- en belastingstesten en schaling van pods

## Author
Beni Dhomi, Quality Engineer. 

## Lessen
- Les I:    Basis Helm Chart begrippen
- Les II:   Leer variables en versionering
- Les III:  Load en Performance testing met HPA

### LES I


### LES II


### LES III
Eerst installeren we de metrics service hiervoor: 
```kubectl apply -f templates/metric-components.yaml```

Doploy'ns wat: kubectl apply -f https://k8s.io/examples/application/php-apache.yaml