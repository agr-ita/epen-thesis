Couverture LaTeX de thèse PSL
=============================

Par [Pierre Guillou](https://cri.ensmp.fr/people/guillou)

Version 3.0 (11 août 2017)

****

Grâce à ce fichier de style, vous pourrez directement compiler votre
thèse LaTeX avec la couverture !

Fichiers du projet
------------------

Ce projet contient les fichiers suivants :

* [psl-cover.sty](psl-cover.sty) : le fichier de style principal à
  importer dans votre projet de thèse LaTeX
* [logo-institute.png](logo-institute.png) : le logo de
  l'établissement (ici celui de l'école des mines)
* [logo-psl.jpg](logo-psl.jpg) : le logo actuel de PSL
* [sample.tex](sample.tex) : un fichier d'exemple d'utilisation
* [sample.pdf](sample.pdf) : le résultat après compilation
* [README.md](README.md) : à l'origine de la présente page

L'ensemble de ces fichiers peut se récupérer directement au format
[archive tar](psl-cover.tar) ou au format
[compressé zip](psl-cover.zip).

Prérequis
---------

Ce fichier de style LaTeX a été testé sous Ubuntu 14.04, Ubuntu 16.04,
Arch Linux et Windows 10 (MikTeX 2.9).

Une distribution LaTeX de type Texlive (de préférence à jour) est bien
évidemment nécessaire.

La police Arial devra être installée si vous utilisez le compilateur
LuaLaTeX (packages msttfcorefonts sous Ubuntu et Debian, ttf-ms-fonts
sous ArchLinux). Par défaut, PDFLaTeX se rabat élégamment sur la
police Helvetica, proche d'Arial et normalement inclue dans votre
distribution LaTeX.

Le paquet LaTeX `iftex` peut manquer sous Ubuntu 12.04. On pourra le
télécharger sur
[CTAN](https://www.ctan.org/tex-archive/macros/latex/contrib/iftex).

Utilisation basique
-------------------

Seuls les deux logos et le fichier psl-cover.sty sont nécessaires pour
générer la couverture. Il suffit de les placer à la racine du projet
LaTeX courant et d'importer le fichier de style dans le préambule de
votre document principal.

```latex
\usepackage{psl-cover}
```

Les quatre pages de couverture devraient se générer automatiquement si
un appel à la méthode `\maketitle` est présent dans le corps du
document.

Les informations manquantes peuvent être fournies au travers des méthodes

* `\title` pour le titre
* `\author` pour l'auteur
* `\doctoralschool` pour le nom et le numéro de l'école doctorale
* `\specialty` pour la spécialité
* `\supervisor` pour le voire les (limité à 2) directeur(s) de thèse
* `\jury` pour le jury de thèse
* `\frabstract` pour le résumé en français
* `\enabstract` pour le résumé en anglais
* `\frkeywords` pour les mots-clés en français
* `\enkeywords` pour les mots-clés en anglais

(ou directement éditées à la bonne place dans le fichier psl-cover.sty).

Le fichier sample.tex fournit un exemple basique d'utilisation basé
sur ce modèle.  Attention, ce fichier se compile avec LuaLaTeX et non
PDFLaTeX. Pour retrouver la compatibilité avec PDFLaTeX, remplacer

```latex
\usepackage{fontspec}
```

par le classique diptyque

```latex
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
```

Et si vous êtes comme moi et que vous ne voulez pas placer les
fichiers de couverture à la racine de votre projet de thèse, la
commande `\logopath` sert à modifier le chemin relatif depuis la
racine vers les logos.

Dans le cas où vous avez deux directeurs de thèse, la syntaxe à
adopter pour ajouter le second directeur est la suivante :

```latex
\supervisor[Prénom2 Nom2]{Prénom1 Nom1}
```

Le second nom, passé en argument optionnel à la commande, sera placé
après le premier nom.

J'ai aussi ajouté les commandes `\thefrabstract`, `\theenabstract`,
`\thefrkeywords` et `\theenkeywords` qui permettent de réutiliser les
résumés et les mots clés dans une autre partie de votre thèse.

Adaptation à d'autres établissements PSL
----------------------------------------

La présente feuille de style, bien que spécifique à l'école des mines,
peut facilement (enfin, je l'espère…) être adaptée à d'autres
établissements de l'Université de recherche Paris Sciences et Lettres.

Pour ce faire, la feuille de style fournit, d'une part, la méthode

```latex
\institute{nom d'établissement}
```

(par défaut réglée à « MINES ParisTech »), qui s'utilise de la même
façon que les autre méthodes décrites ci-desssus.

Il s'agit, ensuite, de remplacer le
fichier [logo-institute.png](logo-institute.png), qui contient
actuellement le logo de l'école des mines, par celui de
l'établissement adéquat.

Si la mise à l'échelle du logo sur la couverture rend mal, il est
possible de modifier sa taille directement dans la feuille de style (à
la ligne 199 ou pas loin).

Deux-trois détails d'implémentation
-----------------------------------

Le fichier psl-cover.sty surcharge la méthode `\maketitle` et génère
deux feuilles de couvertures au début et à la fin, avec une page
blanche intercalaire.

Si, néanmoins, vous souhaitez conserver l'usage de `\maketitle`, par
exemple pour générer une page de titre hors couverture, l'option
`nomaketitle`, à passer au package, désactive cette surcharge.

Dans ce cas, une méthode alternative `\pslcover` peut être utilisée
pour générer la couverture. Attention, il faut utiliser cette commande
avant `\maketitle`, afin de s'assurer que la page de couverture est
bien au début du document :

```latex
\usepackage[nomaketitle]{psl-cover}
...
\begin{document}
...
\pslcover{}
\maketitle{}
...
\end{document}
```

Cette commande `\pslcover` se décompose en `\pslfrontcover` et
`\pslbackcover` qui décrivent respectivement la première et la
dernière feuille de couverture.

J'ai utilisé le langage de dessin vectoriel *tikz* afin de dessiner le
logo PSL en arrière-plan, ainsi que pour placer les champs texte dans
les pages. Si d'aventure ceux-ci s'avéraient mal placés, il est
toujours possible d'éditer leur position à la main :).

Informations pratiques
----------------------

Les félicitations, louanges, commentaires, remarques, critiques,
insultes ou rapports de bugs peuvent être adressées à l'auteur de ce
document via l'email `pierre dot guillou at mines-paristech dot
fr`. Ce dernier se réservera le droit de répondre selon son emploi du
temps de doctorant de 3<sup>e</sup> année, de post-doctorant, ou de
tout autre poste qu'il occupera par la suite.

Remerciements
-------------

Ce projet LaTeX n'aurait pas été rendu possible sans les essais des
doctorants et doctorantes des centres de recherche en informatique et
en morphologie mathématique de l'école des mines, qui m'ont permis de
tester et d'améliorer la portabilité des premières versions de mon
code.

Plus tard, les retours et questionnements des utilisateurs ont,
notamment, permis d'affiner la documentation du projet, qui, je
l'espère, saura se montrer compréhensible et exhaustive.

Que toutes et tous en soient remerciés.
