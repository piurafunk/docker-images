# Laravel 5.4
The base directory for the Laravel application is `/home/laravel/app`. This is also the current working directory when you `exec` into the container. 

It is recommended to mount a volume, so that the files can be edited outside of the container, usually by an IDE (ie, PHPStorm).

>-v /path/on/host:/home/laravel/app


It is advised to create `/path/on/host` before launching the container, and setting the permissions correctly. The uid and gid of the container user are both 1000. This can be changed by installing the `shadow` package and using the `usermod` and `groupmod` commands.
