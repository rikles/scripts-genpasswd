genpasswd
=========

`genpasswd.sh` is a script to generate password.

Generated password is print to the standard output (`/dev/stdout`)



Installation
------------
To use this script, you have to add execution right to it :


    chmod u+x genpasswd.sh


If you want it always available, you can :

  * copy it in your `~/bin` directory
  * or add the script directory to the `PATH` environnement variable



Configuration
-------------
The default configuration is in the "`Variables`" section :

```bash
    PASSWORD_LENGTH=15
    CHARACTER_SET="[:alnum:]"   # -> A-Za-z0-9
    RANDOM_INPUT="/dev/urandom"
```

Vairables definitions :

  * `PASSWORD_LENGTH` : the desired password length
  * `CHARACTER_SET` : the character set used to generate the password, as it is defined in the `tr` command :
    * see : `tr --help`
  * `RANDOM_INPUT` : file used to get the random characters


You can change these values to get the default configuration you want.



Usage
-----
to use this script :

  * if it is in yout `PATH`, run `genpasswd.sh [OPTIONS]`
  * else, run it like any others scripts :
    * `cd <SCRIPT_DIR>; ./genpasswd.sh [OPTIONS]`
    * `/<SCRIPT_DIR>/genpasswd.sh [OPTIONS]`


### Options
This script provides some options to change its default configuration or use an interactive mode.
For more information, use the `--help` option :

    genpasswd.sh --help



Contributing
------------
  * Fork it !
  * Clone your fork : `git clone <url>`
  * Create your feature branch : `git checkout -b my-new-feature`
  * No tabs please !
  * Modify files and add them to the staging area : `git add <FILES>`
  * Commit your changes : `git commit -am 'Add some feature'`
  * Push to the branch : `git push origin my-new-feature`
  * Submit a pull request



License
-------
This script is under the _GNU General Public License version 3_ <http://www.gnu.org/licenses/>.

See this file : `./COPYING`
