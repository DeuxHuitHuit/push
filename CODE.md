# Push script

## install.sh
This runs on the user's machine. Not in a vm. This is the file that is executed when the user install the image for the first time.
This file will make sure the ENV variables are set up on the user's machine and will download the necessary files to the user's machine for the image's setup.

## Dockerfile
Most of the heavy lifting is done in the Dockerfile. This is the file that is used to build the image. All the dependencies are listed in it. It copies the user's SSH keys to it and setup the ENV variables inside the container.

Note that one ENV var is hardcoded for the Slack Webhook 1password ID. Since we will all use the same 1password entry for it.

## checkout.sh
This is the weird one. This file is included in the image and will be executed at every single push. It's only job is to checkout the wanted project with SVN and install NPM packages.

checkout.sh will ask the user to log into it's 1password account and then save a temporary token to be used by the other push scripts.

## deploy (inside Craft's REPO)
[Reference](https://github.com/DeuxHuitHuit/craft-template/blob/master/deploy)

This file is really where the magic happen. It deals with every critical steps of the push.

- The building phase
- Database backup
- Shutting down the website
- Uploading to the staging/production server
- Recompiling the composer's autoload file
- Flushing all caches
- Waking up the website
- Notifying the team in slack via a webhook call

**This file needs to be configured in every single projects before you run it.** (line 5, 6 and 7)

## push (inside Craft's REPO)
[Reference](https://github.com/DeuxHuitHuit/craft-template/blob/master/push)

This file is used to find the container for this project and execute checkout.sh then deploy
