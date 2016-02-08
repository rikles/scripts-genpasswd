genpasswd
=========

`genpasswd.sh` est un script de génération de mot de passe.

Le mot de passe généré est affiché sur la sortie standard (`/dev/stdout`).



Installation
------------
Afin d'utiliser ce script, vous devez y ajouter les droits d'exéctution :


    chmod u+x genpasswd.sh


Afin d'avoir ce script toujours disponible, vous pouvez :

  * le copier votre répertoire `~/bin`
  * ou ajouter le répertoire du script à la variable d'environnment `PATH`



Configuration
-------------
La configuration par défaut de ce script est disponible dans la section "`Variables`" :

```bash
    PASSWORD_LENGTH=15
    CHARACTER_SET="[:alnum:]"   # -> A-Za-z0-9
    RANDOM_INPUT="/dev/urandom"
```

Voici la définition des variables :

  * `PASSWORD_LENGTH` : Taille du mot de passe
  * `CHARACTER_SET` : jeu de caractères utilisé pour générer le mot de passe, définis comme pour la commande `tr` :
    * voir : `tr --help`
  * `RANDOM_INPUT` : fichier utilisé pour acquérir aléatoirement des caractères


Vous pouver bien entendu modifier ces valeurs afin d'avoir la configuration par défaut que vous souhaitez.



Utilisation
-----------
Pour faire appel à ce script :

  * s'il est dans votre `PATH` : utiliser la commande `genpasswd.sh [OPTIONS]` directement
  * sinon, lancer ce script comme n'importe quel autre script :
    * `cd <SCRIPT_DIR>; ./genpasswd.sh [OPTIONS]`
    * `/<SCRIPT_DIR>/genpasswd.sh [OPTIONS]`


### Options
Ce script accepte plusieurs options afin de modifier sa configuration par défaut ou utiliser une mode interactif.
Pour plus de détail, veuillez vous utiliser l'option `--help` :

    genpasswd.sh --help



Contribuer
----------
  * Faites un fork du dépôt git
  * Clonez votre fork : `git clone <url>`
  * Créez une branche pour votre nouvelle fonctionnalité : `git checkout -b my-new-feature`
  * N'utilisez de tabulations, s'il vous plait !
  * Modifiez les fichiers nécessaires et ajoutez-les à l'index : `git add <FILES>`
  * Faites un commit de vos changements : `git commit -am 'Add some feature'`
  * Faites un push de votre branche : `git push origin my-new-feature`
  * Ouvrez une pull request



Licence
-------
Ce script est sous licence _GNU General Public License version 3_ <http://www.gnu.org/licenses/>.

Voir le fichier `./COPYING`
