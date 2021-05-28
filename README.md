# POOUUUUUCHE

## Preparation before the installation

### 1password
Create a private entry with your SVN credentials. Make sure to only use the fields `username` and `password` and you can give it the name of your choice. Take note of your 1password entry id. You will need it later.

### ENV Variables
We need four env variable installed on your machine.
1. `OP_AUTH_DOMAIN` -> `<your subdomain>.1password.com` the domain used by your 1password account.
2. `OP_AUTH_EMAIL` -> `satan@hell.fire` your email associated with your 1password account.
3. `OP_AUTH_SECRET_KEY` -> `XX-XXXXXX-XXXXXX-XXXXX-XXXXX-XXXXX-XXXXX` your 1password secret key.
4. `OP_SVN_ENTRY` -> `XXXXXXXXXXXXXXXXXXXXXXXXXXXX` remember the entry id your created earlier? This is it.

#### Add variables on Windows
Please follow [this tutorial](https://phoenixnap.com/kb/windows-set-environment-variable#ftoc-heading-4) to add an ENV variable.

#### Add variables on MacOS and Linux
You can add your variables via your .bash_profile/rc/aliases with `export`. e.g.: `export foo='bar'`

### Docker
You need to download [Docker](https://www.docker.com/products/docker-desktop) before the installation.

## The actual installation
After all the steps above are done, **restart** your terminal and run this!

```
curl -sL https://raw.githubusercontent.com/DeuxHuitHuit/push/main/install.sh | bash -
```
