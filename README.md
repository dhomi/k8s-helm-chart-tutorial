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
- CD naar de lesmap: ```cd les-III```

- creer een namespace, bv techlab: 
```kubectl create namespace techlab```

- laat alle namespaces zien: 
```kubectl get ns```


#### Installeer de metrics service: 
```kubectl apply -f templates/metric-components.yaml```

- Check de installatie: 
```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           19d
```

#### Het mooiste in een tmux... dan zie je in een scherm alles live
- SECRETS: check je deployments. Je ziet er twee
```kubectl get secrets -n techlab -w```
- PODS: check je pods
```kubectl get pods -n techlab -w```
- HPA: check je HPA
```kubectl get hpa -n techlab -w```

#### Nu het php-apache deployen
- Deploy het php-apache.yaml die ```OK!``` in frontend toont:
```kubectl apply -f templates/php-apache.yaml```


#### Deploy een HPA scaling 
Loop ```wget http://php-apache``` in dit container
- De yaml is in ```templates/Oneindige-calls.yaml``` en je kan dit via de shell script aanroepen en tegelijk ook de deployment ermee bewerken: 
- Usage: ```./scaling.sh <replica_count>```
Bijvoorbeeld: ```./scaling.sh 4``` zorgt ervoor dat de oneindige-calls.yaml wordt uitgevoerd met vier pods.
*opmerking: scaling.sh moet wel uitvoerbaar zijn, anders: ```chmod + scaling.sh```*
- Voor deze scaling deployment gebruik ik de BusyBox in een container dat een super-lichtgewicht is met veel Linux tools, zoals wget