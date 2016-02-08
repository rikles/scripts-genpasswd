#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------
# Copyright (c) 2015, 2016 Loïc Guibert <lfdummy-devel@yahoo.fr>
#-----------------------------------------------------------------------------------------------------------------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------------------------------------------
# Objet : Script de génération de mot de passe aléatoire
#-----------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------
# Variables
#-----------------------------------------------------------------------------------------------------------------
PASSWORD_LENGTH=15
CHARACTER_SET="[:alnum:]"   # -> A-Za-z0-9
RANDOM_INPUT="/dev/urandom"


#-----------------------------------------------------------------------------------------------------------------
# Fonction usage
#-----------------------------------------------------------------------------------------------------------------
function usage {
    THE_LANGUAGE=`echo $LANG | head -c2 | tr [:lower:] [:upper:]`

    if [ "_$THE_LANGUAGE" = "_FR" ]; then
        cat <<EOF_STR
Objet : Génère un mot de passe aléatoire et l'affiche sur la sortie standard.

Usage :
    `basename "$0"`
        [-c|--char-set <character set> ] [-t <type>] [-l|--length <longueur>] [-s|--strong] [-i|--interactive]

-l | --length : longueur du mot de passe. Défaut : ${PASSWORD_LENGTH}

<character set> : ensemble de caratères définis comme pour la commande 'tr'
    voir : tr --help
    Défaut : ${CHARACTER_SET}

<type> :
    alnum   -> toutes les lettres et les chiffres
    alpha   -> toutes les lettres
    digit   -> tous les chiffres
    graph   -> tous les caractères imprimables, sans inclure les blancs
    print   -> tous les caractères imprimables, incluant les blancs
    lower   -> tous les lettres minuscules
    upper   -> toutes les lettres majuscules
    punct   -> tous les caractères de ponctuation
    xdigit  -> tous les chiffres hexadécimaux

-s | --strong : utiliser /dev/random au lieu de /dev/urandom

-i | --interactive : mode interactif

Exemple :
    `basename "$0"`
    `basename "$0"` -c [:upper:][:digit:] -l 10
    `basename "$0"` -t alnum
    `basename "$0"` -i
EOF_STR

    else
        cat <<EOF_STR
Genarate a random password and print it to the standard output.

Usage :
    `basename "$0"`
        [-c|--char-set <character set> ] [-t <type>] [-l|--length <longueur>] [-s|--strong] [-i|--interactive]

-l | --length : desired password length. Default : ${PASSWORD_LENGTH}

<character set> : character set used to generate password like in the 'tr' command
    see : tr --help
    Default : ${CHARACTER_SET}

<type> :
    alnum   -> letters and numbers
    alpha   -> letters
    digit   -> numbers
    graph   -> all printable characters, without blanks
    print   -> all printable characters, with blanks
    lower   -> lowercase letters
    upper   -> uppercase letters
    punct   -> punctuation characters
    xdigit  -> hexadecimal numbers

-s | --strong : use /dev/random instead of /dev/urandom

-i | --interactive : interactive mode

Example :
    `basename "$0"`
    `basename "$0"` -c [:upper:][:digit:] -l 10
    `basename "$0"` -t alnum
    `basename "$0"` -i
EOF_STR

    fi
}


#-----------------------------------------------------------------------------------------------------------------
# Fonction setCharacterSet
# --------------------------------------------------
# Paramètres :
#   $1 : nom de référence du CharacterSet :
#           alnum   -> toutes les lettres et les chiffres
#           alpha   -> toutes les lettres
#           digit   -> tous les chiffres
#           graph   -> tous les caractères imprimables, sans inclure les blancs
#           print   -> tous les caractères imprimables, incluant les blancs
#           lower   -> tous les lettres minuscules
#           upper   -> toutes les lettres majuscules
#           punct   -> tous les caractères de ponctuation
#           xdigit  -> tous les chiffres hexadécimaux
#-----------------------------------------------------------------------------------------------------------------
function setCharacterSet {
    if [ "_$1" = "_" ]; then
        echo "<type> invalide !"
        echo ""
        usage
        exit 1
    fi

    case $1 in
        alnum | alpha | digit | graph | print | lower | upper | punct | xdigit)
            CHARACTER_SET="[:$1:]"
            ;;
        * )
            echo "<type> invalide !"
            echo ""
            usage
            exit 1
    esac
}


#-----------------------------------------------------------------------------------------------------------------
# Fonction interactive
#-----------------------------------------------------------------------------------------------------------------
function interactive {
    # ===== PASSWORD_LENGTH
    OK=0
    while [ $OK -ne 1 ]; do
        read -e -p "Longueur du mot de passe ? (${PASSWORD_LENGTH}) " -i "${PASSWORD_LENGTH}" RESPONSE
        if [ "_$RESPONSE" != "_" -a $RESPONSE -gt 0 ]; then
            OK=1
            PASSWORD_LENGTH=${RESPONSE}
            echo "PASSWORD_LENGTH : ${PASSWORD_LENGTH}"
        else
            echo "Veuillez saisir un nombre > 0"
        fi
    done

    # ===== CHARACTER_SET
    OK=0
    while [ $OK -ne 1 ]; do
        read -e -p "Ensemble de caractère ? (${CHARACTER_SET}) " -i "${CHARACTER_SET}" RESPONSE
        if [ "_$RESPONSE" != "_" ]; then
            OK=1
            CHARACTER_SET="${RESPONSE}"
            echo "CHARACTER_SET : ${CHARACTER_SET}"
        else
            echo "Exemple :"
            echo "    A-Za-z0-9"
            echo "    [:alnum:]"
            echo "    [:graph:]"
            echo "    [:upper:][:digit:]"
        fi
    done
}


#-----------------------------------------------------------------------------------------------------------------
# Fonction genpass
#-----------------------------------------------------------------------------------------------------------------
function genpass {
    < /dev/urandom tr -cd "${CHARACTER_SET}" | head -c${PASSWORD_LENGTH}
    RETURN=$?
    echo
    return ${RETURN}
}


#-----------------------------------------------------------------------------------------------------------------
# Paramètres
#-----------------------------------------------------------------------------------------------------------------
while [ "_$1" != "_" ]; do
    case $1 in
        -t | --type )           shift
                                setCharacterSet "$1"
                                ;;
        -c | --char-set )       shift
                                CHARACTER_SET="$1"
                                ;;
        -l | --length )         shift
                                PASSWORD_LENGTH="$1"
                                ;;
        -i | --interactive )    interactive
                                ;;
        -s | --strong)          RANDOM_INPUT="/dev/random"
                                ;;
        -h | --help )           usage
                                exit 0
                                ;;
        * )                     usage
                                exit 1
                                ;;
    esac
    shift
done


#-----------------------------------------------------------------------------------------------------------------
# EXECUTION DU PROGRAMME
#-----------------------------------------------------------------------------------------------------------------
genpass
exit $?
