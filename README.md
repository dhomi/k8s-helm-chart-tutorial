# k8s-helm-chart-tutorial
Leer spelen met containers op Kubernetes met Docker, Helm Charts en prestatie- en belastingstesten en schaling van pods

## Author
Beni Dhomi, Quality Engineer. 
repo: 
```git clone https://github.com/dhomi/k8s-helm-chart-tutorial.git```
## Lessen
- Les I:    Basis Helm Chart begrippen
- Les II:   Leer variables en versionering
- Les III:  Load en Performance testing met HPA

### LES I


### LES II


### LES III
CD naar de lesmap: ```cd les-III```

Eerst installeren we de metrics service hiervoor: 
```kubectl apply -f templates/metric-components.yaml```

Check de installatie: 
```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           19d
```
Doploy het php-apache.yaml die ```OK!``` in frontend toont: 
```kubectl apply -f templates/php-apache.yaml```

Laad een HPA scaling pod die loop naar de php-apache doet. De scaling.sh script gebruik je als ```Usage: ./scaling.sh <replica_count>```

Bijvoorbeeld: ```./scaling.sh 4``` zorgt ervoor dat de oneindige-calls.yaml wordt uitgevoerd met vier pods.
