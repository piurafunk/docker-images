# Laravel 5.4
The base directory for the Laravel application is `/home/www-data/$app_name`. This is also the current working directory when you `exec` into the container. The app name will determine the subdirectory that it is stored in (default: app). To change the directory, use the environment variable `app_name`:

    -e app_name=APP_NAME_HERE

It is recommended to mount a volume, so that the files can be edited outside of the container, usually by an IDE (ie, PHPStorm).

    -v /path/on/host:/home/www-data/APP_NAME_HERE

The app name specified in the volume mount should match the `app_name` environment variable. It is advised to create `/path/on/host` before launching the container, and setting the permissions correctly. The uid and gid of the container user are both 1000, but this can be change inside the container by running `usermod -u 1000 www-data` and `groupmod -g 1000 www-data`, changing 1000 to the appropriate ID.
