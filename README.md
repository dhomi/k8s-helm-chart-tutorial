# k8s-helm-chart-tutorial
Leer spelen met containers op Kubernetes met Docker, Helm Charts en prestatie- en belastingstesten en schaling van pods

## Author
Beni Dhomi, Quality Engineer. 
repo: 
```git clone https://github.com/dhomi/k8s-helm-chart-tutorial.git```
# Lessen
- Les I:    Basis Helm Chart begrippen
- Les II:   Leer variables en versionering
- Les III:  Load en Performance testing met HPA

## LES I

## LES II


## LES III
Leerdoelen:
- installeer de metrics plugin voor k8s
- installeer de php-apache met HPA erin
- installeer de oneindige-calls ping-er
- maak dat oneidige-calls meer pods worden zodat de php-apache automatisch up-scales

### Installeer de metrics plugin voor k8s
```kubectl apply -f templates/metric-components.yaml```

- Check de installatie: 
```kubectl get deployment metrics-server -n kube-system```

```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           19d
```

### installeer de php-apache met HPA erin 
- CD naar de lesmap: ```cd les-III```
- creer een namespace, bv techlab: 
```kubectl create namespace techlab```
- laat alle namespaces zien: 
```kubectl get ns```
- Deploy het php-apache.yaml die ```OK!``` in frontend toont:
```kubectl apply -f php-apache.yaml -n techlab```


### installeer de oneindige-calls ping-er
- ```kubectl apply -f templates/Oneindige-loop.yaml -n techlab```

Wat doet dit BusyBox container?
- De yaml is in ```templates/Oneindige-calls.yaml```
 Voor deze scaling deployment gebruik ik de BusyBox in een container dat een super-lichtgewicht is met veel Linux tools, zoals wget en daarin runnen we een Loop ```wget http://php-apache``` die op zijn beurt load creert op de php-apache

### maak dat oneidige-calls meer pods worden zodat de php-apache automatisch up-scales
```kubectl scale deployment oneindige-calls --replicas=8 -n techlab```
anders kan het ook via live-edit: ```kubectl edit deployment oneindige-calls -n techlab```
Dit is de Vim editor die dat doet, zoek replicas: 5 en zet het naar wens. Save+exit

Kijk nu hoeveel deployments er zijn, wacht effe want het duurt minuut of twee voordat je wat ziet, als het goed is heb je nu 8 oneindige-loops en een stuk of 15 php-apache

Speel nu ermee, zet de replicas op 1 en zie hoe php-apache aantallen verminderen
```kubectl scale deployment oneindige-calls --replicas=1 -n techlab```

Als je er klaar mee bent, en je wil alles verwijderen/cleanup, dan verwijder je de namespace: 
```kubectl delete ns techlab```

# DEBUG COMMANDS:
- Check je deployments
```kubectl get deployments -n techlab -w```
- Check je pods
```kubectl get pods -n techlab -w```
- Check je HPA
```kubectl get hpa -n techlab -w```

Tip: gebruik tmux in je shell, per commando een pane: super cool ;)
