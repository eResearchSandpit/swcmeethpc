# Copying data

Large data files are not usually part of repositories, especially when data is in binary format. User space on free services like GitHub is also limited, so we will need to find a way to copy files forth and back between our own computer and the HPC. Depending on the number of files and file sizes, different programs are available to do the job.

Let's first quit our HPC session:
```
-bash-4.2$ exit
```
~~~ {.output}
logout
Connection to fitzroy.nesi.org.nz closed.
~~~
We can now use the `scp` program to copy our output file from the HPC to our own computer:
```
-bash-4.2$ scp user@fitzroy.nesi.org.nz:matmul/swcmeethpc/python-example_1080085.out .
```
~~~ {.output}
user@fitzroy.nesi.org.nz's password:
python-example_1080085.out                    100%  119     0.1KB/s   00:00
~~~
The `scp` program works much the same as the `cp` program for copying files, but we now needed to include our user name and the name of the HPC to tell `scp` that it should contact another computer. Note that `scp` uses `ssh` under the hood to encrypt files.

It is usually necessary to transfer more than just one file, and given that transfer speed over the internet is limited, it is also a good idea to compress files before transmission. The `tar` program provides an easy way to bundle up any number of files into an archive and compress it, despite its rather advanced age (`tar` is an abbreviation of "tape archive", describing the original purpose of the `tar` program).

Let's create a new directory with a number of files on our own computer:
```
$ mkdir food
$ echo "Toast, jam, tea" > food/breakfast.txt
$ echo "Salad, sandwich, water" > food/lunch.txt
$ echo "Soup, bread, fruit salad" > food/dinner.txt
```
We can now pack up the directory and compress it into a single "tarball":
```
$ tar czf food.tar.gz food
```
The option "c" stands for "create" - we want to create a new archive. Passing "z" asks `tar` to compress the archive using the `gzip` compression program, which is available for all platforms. The last option "f" lets us set the name of the archive, where we will choose "food.tar.gz". The suffix ".tar.gz" is a convention to show that this is a `gzip`-compressed `tar` archive.

Let's look at the results:
```
$ ls food*
```
~~~ {.output}
food.tar.gz

food:
breakfast.txt  dinner.txt  lunch.txt
~~~
As expected, we have a directory with three text files in it, and a `tar` archive. We can now transfer the archive to the remote computer using `scp`:
```
$ scp food.tar.gz user@fitzroy.nesi.org.nz:~/
```
~~~ {.output}
user@fitzroy.nesi.org.nz's password:
food.tar.gz                                              100%  271     0.3KB/s   00:00
~~~
Note that the target `user@fitzroy.nesi.org.nz:~/` asks `scp` to copy the file into our home directory on Fitzroy. Let's log on again and unpack the files:
```
$ ssh user@fitzroy.nesi.org.nz
```
```
-bash-4.2$ gtar xzf food.tar.gz
```
Note that we need to use `gtar` instead of `tar` on Fitzroy: Fitzroy's operating system AIX has its own implementation of `tar`, which does not support all features of "GNU tar".

We should now have a new folder with our text files:
```
-bash-4.2$ ls food*
```
~~~ {.output}
food.tar.gz

food:
breakfast.txt  dinner.txt  lunch.txt
~~~

There are many other ways to transfer files:

* The `sftp` program can be used to open an interactive file transfer session
* The `rsync` program can be used to synchronise entire directory trees between our computer and the HPC
* High-performance data transfer services, such as "Globus", can be used if you need to transfer very large amounts of data, but they require specialised computers (so-called "data transfer nodes") that are connected to fast netoworks at your own institution and the HPC
