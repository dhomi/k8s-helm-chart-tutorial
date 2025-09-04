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

### Deploy de metrics plugin voor k8s
```kubectl apply -f templates/metric-components.yaml```

- Check de installatie: 
```kubectl get deployment metrics-server -n kube-system```

```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           19d
```

### Deploy de php-apache met HPA erin 
- CD naar de lesmap: ```cd les-III```
- creer de techlab namespace: 
```kubectl create namespace techlab```
- check het: 
```kubectl get ns```
- Deploy het php-apache.yaml die ```OK!``` in frontend toont:
```kubectl apply -f php-apache.yaml -n techlab```


### Deploy de oneindige-calls ping-er
- ```kubectl apply -f templates/Oneindige-loop.yaml -n techlab```

Wat doet dit ‘BusyBox based container’?
Het loopt een GET request naar de php-apache toe om LOAD te creeren.

Is de php-apache CPU > 75% belast? Dan implementeert de HPA meer pods om totdat de totale load = 75%. 

### Maak 8 oneidige-calls replicas
```kubectl scale deployment oneindige-calls --replicas=8 -n techlab```

Het kan ook via live-edit: 

```kubectl edit deployment oneindige-calls -n techlab```
Dit gebeurt in de Vim editor. Zoek daar naar ‘replicas: 5’ en zet het naar wens. Save+exit (shift+:, dan x+enter)

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
