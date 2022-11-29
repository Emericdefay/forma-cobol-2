<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="../com/cobol.png" alt="COBOL LOGO"></a>
</p>

<h3 align="center">COBOL POE - Part 2</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/emericdefay/forma-cobol-2.svg)](https://github.com/emericdefay/forma-cobol-2/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/emericdefay/forma-cobol-2.svg)](https://github.com/emericdefay/forma-cobol-2/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

# Notes:

``PGM015.cbl`` is the COBOL program.  
``PGM015FC.cpy`` & ``PGM015FS.cpy`` are copybooks.  
``FILE015`` is input file. (*just example*)  
``compilation`.jcl`` & ``execution`.jcl`` are JCL code.   
Be sure to verify the **JCL** to make sure that it works on your zOS.  
I explain my setup here : [settings](../README.md/#settings)


# Formation COBOL -  Appareillage de fichiers

## 1.	Objectif de la fiche :  

- Le but de ce programme est de lire les données sur les produits d’une
société qui sont stockés dans un fichier <Produit>.
- L’entreprise COBOLISTE nous a demandé d’éditer un programme cobol pour
afficher un état récapitulatif des statistiques mensuel donnant la quantité
totale produite par atelier par usine et pour toute l’entreprise ainsi que les
quantités défectueuses au cours d’une période déterminée

### Structure de données

- Nous avons comme données en entrée le fichier dont la description d’un
enregistrement est la suivante :

<p align="left">
  <a href="" rel="noopener">
 <img width=500px src="./com/struct.png" alt="data structure"></a>
</p>

- En ce qui concerne les résultats, nous avons créé deux fichiers :
« Résultats » et « Erreurs» qui contiennent respectivement les résultats
et les erreurs obtenues lors de l’exécution du programme.


### Contraintes

- Il est à préciser que l’entreprise est constituée de trois usines et chaque
usine est composée d’un certain nombre d’ateliers (maximum cinq par
usine) et qu’il faut afficher à la fin du rapport la meilleure usine et le
meilleur atelier. Il reste à noter que le fichier utilisé peut contenir des erreurs
de saisie.

- Pour tester notre programme nous avons adapté le fichier « PRODUIT »
dont les enregistrements erronés sont en rouge :

<p align="left">
  <a href="" rel="noopener">
 <img width=500px src="./com/data-example.png" alt="data example"></a>
</p>

### Etat de Sortie

<p align="left">
  <a href="" rel="noopener">
 <img width=500px src="./com/sortie1.png" alt="sortie 1"></a>
</p>

<p align="left">
  <a href="" rel="noopener">
 <img width=500px src="./com/sortie2.png" alt="sortie 2"></a>
</p>

### Affichage des erreurs

<p align="left">
  <a href="" rel="noopener">
 <img width=500px src="./com/erreurs.png" alt="sortie 2"></a>
</p>


</p>