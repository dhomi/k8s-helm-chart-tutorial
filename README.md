# k8s-helm-chart-tutorial
Leer spelen met containers op Kubernetes met Docker, Helm Charts en prestatie- en belastingstesten en schaling van pods

## Author
Beni Dhomi, Quality Engineer. 
repo: 
```git clone https://github.com/dhomi/k8s-helm-chart-tutorial.git```

## LES I - BASIS K8S 
initieel willen we een kubernetes node gebruiken
bijvoorbeeld Docker Desktop, in settings: Kubernetes aanzetten
dan ook het kubectl commandline tool downloaden

- cd naar les-I map: ```cd les-I```
- check of kubectl werkt: ```kubectl version --client
- een namespace maken ```kubectl create namespace techlab```
- laat alle namespaces zien ```kubectl get ns```

bekijk het bestand **pod.yaml**

- maak de pod aan in de techlab namespace: ```kubectl apply -f pod.yaml -n techlab```
- check het: ```kubectl get pods -n techlab```
- laat meer info zien: ```kubectl describe pod techlab-pod -n techlab```

### Een Deployment 
een deployment zorgt ervoor dat je app altijd draait (gewenst aantal replicas zijn automatisch beheerd).
- bekijk het bestand **deployment.yaml**

- maak de deployment aan in de techlab namespace: ```kubectl apply -f deployment.yaml -n techlab```# voer het uit
- check het: ```kubectl get deployments -n techlab```
- laat de pod zien: ```kubectl get pods -n techlab```
- laat meer info zien: ```kubectl describe pod nginx-pod -n techlab```

### Services
een service zorgt ervoor dat je app bereikbaar is, ook als de pod IP verandert.
- bekijk het bestand **service.yaml**
- maak de service aan in de techlab namespace: ```kubectl apply -f service.yaml -n techlab```
- check het: ```kubectl get services -n techlab``
- laat meer info zien: ```kubectl describe service nginx-service -n techlab```
- check de app in je browser: http://localhost:30001 (of een andere poort als je die hebt ingesteld)    


### Cleanup
- verwijder de namespace: ```kubectl delete ns techlab```
- check het: ```kubectl get ns```
- je kan ook alles apart verwijderen:
```kubectl delete -f pod.yaml -n techlab```
```kubectl delete -f deployment.yaml -n techlab```
```kubectl delete -f service.yaml -n techlab```
- check het: ```kubectl get all -n techlab```


## LES II - VARIABLES EN VERSIEERING


## LES III - SCALING MET HPA en LOAD TESTING
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
- ```kubectl apply -f templates/Oneindige-calls.yaml -n techlab```

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




## LES IV - DEBUG EN EXPERIMENTS

# DEBUG COMMANDS:
- Check je deployments
```kubectl get deployments -n techlab -w```
- Check je pods
```kubectl get pods -n techlab -w```
- Check je HPA
```kubectl get hpa -n techlab -w```

Tip: gebruik tmux in je shell, per commando een pane: super cool ;)

# EXPERIMENTS
Run JMeter Tests using the Docker Image:
You can run your JMeter test collection by mounting the test plan directory to the Docker container and specifying the JMX file to execute.

Replace YOUR_TEST_DIRECTORY and YOUR_TEST_FILE.jmx with your actual test directory and JMX file.

```docker run -it --rm -v /path/to/YOUR_TEST_DIRECTORY:/mnt/jmeter -w /mnt/jmeter justb4/jmeter -n -t /mnt/jmeter/YOUR_TEST_FILE.jmx```

- -it - Runs the container in interactive mode.
- --rm - Removes the container when it stops.
- -v /path/to/YOUR_TEST_DIRECTORY:/mnt/jmeter - Mounts your test directory to the container at /mnt/jmeter.
- -w /mnt/jmeter - Sets the working directory to /mnt/jmeter within the container.
- justb4/jmeter - Specifies the JMeter Docker image.
- -n - Runs JMeter in non-GUI mode.
- -t /mnt/jmeter/YOUR_TEST_FILE.jmx - Specifies the JMX file to execute.
View Test Results:
After the test is completed, you can view the results in the console output. 
You can also configure JMeter to save the test results in various formats, such as CSV or XML, by adding appropriate listeners to your JMX file.