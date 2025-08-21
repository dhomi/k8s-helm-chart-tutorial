#!/bin/bash
# filepath: les-III/scaling.sh

# Usage: ./scaling.sh <replica_count>

NAMESPACE="default" # Pas aan indien nodig
DEPLOYMENT_NAME="oneindige-calls"
DEPLOYMENT_FILE="les-III/templates/Oneindige-calls.yaml"

REPLICAS="${1:-1}"

# Check if deployment exists
kubectl get deployment $DEPLOYMENT_NAME -n $NAMESPACE > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Deployment $DEPLOYMENT_NAME bestaat niet. Deployen met $REPLICAS replicas..."
  # Pas het aantal replicas aan in een tijdelijke yaml
  TMPFILE=$(mktemp)
  sed "s/replicas: [0-9]\+/replicas: $REPLICAS/" "$DEPLOYMENT_FILE" > "$TMPFILE"
  kubectl apply -f "$TMPFILE" -n $NAMESPACE
  rm "$TMPFILE"
else
  echo "Deployment $DEPLOYMENT_NAME bestaat al. Schalen naar $REPLICAS replicas..."
  kubectl scale deployment $DEPLOYMENT_NAME --replicas=$REPLICAS -n $NAMESPACE
fi