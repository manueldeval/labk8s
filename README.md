# Objectif

L'objectif de ce repository est de permettre la construction d'un laboratoire permettant de tester les différents aspects de kubernetes.
Ce laboratoire doit pouvoir s'exécuter sur un serveur unique, mais comme nous voulons créer un cluster mutli-noeuds, nous allons déployer chaque noeud K8S dans un container LXC dédié - cette solution est préférée à des VM pour maximiser le nombre de noeuds possibles et limiter les ressources nécessaires à l'exécution du laboratoire sur le système hôte. 

Le système cible est un PC sous Ubuntu 18.04. Les containers LXC sont basés eux aussi sur une image Ubuntu 18.04.

Le déploiement de ce laboratoire est automatisé via des scripts Ansible - il doit donc être préalablement installé.

# Installation 

```
$ cd ansible
$ ansible-playbook -i environments/lab playbook.yml --extra-vars "ansible_become_pass=<PASSWORD>"
```

# Limitations connues

Ces limitations ne sont probablement pas les seules...

- Le script ne supporte (actuellement) pas un déploiement derrière un proxy.
- Seul le réseau K8S de type flannel est supporté.
 
