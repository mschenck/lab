ArgoCD
======


Initial password
----------------

    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


Port Forward - UI
-----------------

    kubectl port-forward service/argocd-server -n argocd 10444:443
