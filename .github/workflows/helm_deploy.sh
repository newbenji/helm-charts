cd ../../charts
for d in *
do
  echo "Deploying $d to kind"
  (
    cd "$d"
    if [ ! -f ".no_ci" ]; then
      echo "No CI for this chart."
    else
      helm install $d . --wait --timeout 120s 
      helm test $d
    fi
  )
  if [ $? -ne 0 ]; then
    echo "Error during deployment"
    exit 1
  else
    echo "Success ! "
    helm delete $d 
  fi
done

