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
                                      |-> K8s(m1) [10.0.4.4]
                                      |-> K8s(m2) [10.0.4.5]
                                      |-> K8s(s)  [10.0.4.6]
                                      |-> K8s(s)  [10.0.4.7]

```

# Installation 

## Récupération des sources

```
$ git clone https://github.com/manueldeval/labk8s.git
$ cd labk8s/ansible/
```

## Configuration de l'hote

Sur l'hote local, ajouter `.xip.io,.nip.io` dans la variable d'environnement `NO_PROXY` (et eventuellement `no_proxy`) - par exemple dans le fichier `/etc/environment`.
Le lab va largement se baser sur des noms de domaine du type `http://<appli>.10.0.4.10.xip.io`. Dans le cas contraire, et si les requetes http transitent par un serveur mandataire, c'est lui 
qui fera la résolution de nom et tentera de contacter `10.0.4.10`... ce qui n'est évidemment pas possible car il s'agit d'une ip non routée sur l'hote local.


## Configuration des variables

Editer le fichier `./group_vars/all.yml.`

Ce fichier permet de configurer:
- la présence éventuelle d'un proxy http.
- si nous désirons que les master k8s soient aussi des workers.

## Creation de l'infrastructure

```
$ ./shells/create_infra.sh
```
Ansible demande alors de passord root de l'hôte.

## Installation de k8s

```
$ ./shells/install_all.sh
```

# Arret/démarrage du LAB

L'installation démarre les containers, mais des scripts permettent de les arrêter ou de les démarrer.

## Démarrage
```
$ ./shells/start_lab.sh
```
Ansible demande alors de passord root de l'hôte.

## Arrêt
```
$ ./shells/stop_lab.sh
```
Ansible demande alors de passord root de l'hôte.


# Limitations connues

Ces limitations ne sont probablement pas les seules...

- Seul le réseau K8S de type weave est supporté.
- Le cluster etcd n'est actuellement pas sécurisé (par de certificats).
- Presence obligatoire d'un `~/.ssh/id_rsa.pub` sur l'hôte (celui-ci est poussé automatiquement dans le `/root/.ssh/authorized_keys` des containers pour permettre une connexion simplifiée).

 
