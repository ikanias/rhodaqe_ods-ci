***Keywords***
Upgrade RHODS  
   [Arguments]  ${operator_version}
   Oc Patch  kind=CatalogSource  
   ...    name=addon-managed-odh-catalog  
   ...    src={spec:{image: ${RHODS_BUILD.IMAGE}:${operator_version}}} 
   ...    namespace=openshift-marketplace

Verify RHODS Upgrade   
  Wait For Pods Number  1
  ...                   namespace=redhat-ods-operator
  ...                   label_selector=name=rhods-operator  
  ...                   timeout=600
  Wait For Pods Number  6  
  ...                   namespace=redhat-ods-applications
  ...                   label_selector=app=jupyterhub  
  ...                   timeout=400 
  Verify Builds In redhat-ods-applications
  Wait for pods status  namespace=redhat-ods-monitoring  timeout=1200
  Log  "Verified monitoring"  console=yes
  Wait for pods status  namespace=redhat-ods-applications  timeout=120
  Log  "Verified applications"  console=yes
  Wait for pods status  namespace=redhat-ods-operator  timeout=1200
  Log  "Verified operator"  console=yes