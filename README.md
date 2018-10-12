# Objectif

L'objectif de ce repository est de permettre la construction d'un laboratoire permettant de tester les différents aspects de kubernetes.
Ce laboratoire doit pouvoir s'exécuter sur un serveur unique, mais comme nous voulons créer un cluster mutli-noeuds, nous allons déployer chaque noeud K8S dans un container LXC dédié - cette solution est préférée à des VM pour maximiser le nombre de noeuds possibles et limiter les ressources nécessaires à l'exécution du laboratoire sur le système hôte. 

Le système cible est un PC sous Ubuntu 18.04. Les containers LXC sont basés eux aussi sur une image Ubuntu 18.04.

Le déploiement de ce laboratoire est automatisé via des scripts Ansible - il doit donc être préalablement installé.

# Architecture actuelle


```
                                                          |-> etcd1 [10.0.4.14]
                                      |-> HA1 [10.0.4.11]-|-> etcd2 [10.0.4.15]
 -> GW [10.0.4.1] -> VIP [10.0.4.10] -|-> HA2 [10.0.4.12]-|-> etcd3 [10.0.4.16]
    brige de l'hote                   |
                                      |-> K8s(m) [10.0.4.5]
                                      |-> K8s(s) [10.0.4.6]

```

# Installation 

```
$ cd ansible
$ ansible-playbook -i environments/lab playbook.yml --extra-vars "ansible_become_pass=<PASSWORD>"
```

# Limitations connues

Ces limitations ne sont probablement pas les seules...

- Seul le réseau K8S de type weave est supporté.
 
