# Cloning a git repository

Using `git` works just the same on the remote computer as on our laptop. It also highlights one of the many strengths of version control: we can develop code on our own computer and easily transfer it to a HPC system using a repository service, such as GitHub. As `git` will keep track of changes, we can always make sure that we use the correct version of our code.

Let's first log on again:
``` {.bash}
$ ssh user@login.uoa.nesi.org.nz
```

We will use the directory that we created previously:
```
[user@login-01 ~]$ cd matmul
```
~~~ {.output}
[user@login-01 matmul]$
~~~

The `git` command for downloading a repository from GitHub is:
```
[user@login-01 ~]$ git clone https://github.com/tinyendian/swcmeethpc.git
```
~~~ {.output}
Initialized empty Git repository in /home/user/matmul/swcmeethpc/.git/
remote: Counting objects: 69, done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 69 (delta 36), reused 69 (delta 36), pack-reused 0
Unpacking objects: 100% (69/69), done.
[user@login-01 matmul]$
~~~

Let's have a look at the repository contents:
```
[user@login-01 ~]$ cd swcmeethpc
[user@login-01 ~]$ ls
```
~~~ {.output}
01-ssh.html  03-preparing.html     05-scheduler.html  example-03.sl  matmulti1.py  README.html
01-ssh.md    03-preparing.md       05-scheduler.md    example-04.sl  matmulti2.py  README.md
02-git.html  04-optimisation.html  example-01.sl      example-05.sl  nvblas.conf   ssh-keypairs.html
02-git.md    04-optimisation.md    example-02.sl      images         nvblas.log    ssh-keypairs.md
~~~

> ## Challenge
>
> Can you think of reasons why you would need to make changes to your git repository on the remote computer? How would you carry these changes over to the repository on your own computer?