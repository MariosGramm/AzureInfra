Αυτό το project αποσκοπεί στη δημιουργία μιας Virtual Machine (VM) στο Azure, μέσα σε ένα Virtual Network (VNet) και ένα Subnet, αξιοποιώντας Bicep templates. Η ανάπτυξη χωρίζεται σε δύο βασικά βήματα:

Resource Group Deployment: Δημιουργία του resource group με χρήση του αρχείου resource-group.bicep και των παραμέτρων από το αρχείο resource-group.bicep.param.
Resource Deployment: Δημιουργία όλων των υπόλοιπων πόρων, όπως το VM, το Virtual Network, και το Subnet, με χρήση του αρχείου resources-deployment.bicep και των παραμέτρων από το αρχείο resources-deployment.bicep.param.
Όλες οι παράμετροι για τα resources ορίζονται μέσω .bicep.param αρχείων, προσφέροντας ευελιξία στη ρύθμιση.



This project aims to create a Virtual Machine (VM) in Azure, within a Virtual Network (VNet) and a Subnet, utilizing Bicep templates. The deployment is divided into two main steps:

Resource Group Deployment: Creation of the resource group using the resource-group.bicep file and the parameters from the resource-group.bicep.param file.
Resource Deployment: Creation of all other resources, such as the VM, the Virtual Network, and the Subnet, using the resources-deployment.bicep file and the parameters from the resources-deployment.bicep.param file.
All resource parameters are defined through .bicep.param files, providing flexibility in configuration.