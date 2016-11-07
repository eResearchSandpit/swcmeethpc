# Cloning a git repository

Using `git` works just the same on the remote computer as on our laptop. It also highlights one of the many strengths of version control: we can develop code on our own computer and easily transfer it to a HPC system using a repository service, such as GitHub. As `git` will keep track of changes, we can always make sure that we use the correct version of our code.

Let's first log on again:
``` {.bash}
$ ssh user@fitzroy.nesi.org.nz
```

We will use the directory that we created previously:
```
-bash-4.2$ cd matmul
```

The `git` command for downloading a repository from GitHub is:
```
-bash-4.2$ git clone https://github.com/tinyendian/swcmeethpc.git
```
~~~ {.output}
Cloning into 'swcmeethpc'...
remote: Counting objects: 120, done.
remote: Total 120 (delta 0), reused 0 (delta 0), pack-reused 120
Receiving objects: 100% (120/120), 309.33 KiB | 133 KiB/s, done.
Resolving deltas: 100% (69/69), done.
~~~

The repository has a separate branch with Fitzroy-specific examples:
```
-bash-4.2$ cd swcmeethpc
-bash-4.2$ git checkout fitzroy
```
~~~ {.output}
Branch fitzroy set up to track remote branch fitzroy from origin.
Switched to a new branch 'fitzroy'
~~~

Let's look at the output:
```
-bash-4.2$ ls
```
~~~ {.output}
01-ssh.html           04-optimisation.md    example-05.sl         nvblas.conf
01-ssh.md             05-scheduler.html     images                nvblas.log
02-git.html           05-scheduler.md       matmulti1.f90         ssh-keypairs.html
02-git.md             example-01.sl         matmulti1.py          ssh-keypairs.md
03-preparing.html     example-02.sl         matmulti2.f90
03-preparing.md       example-03.sl         matmulti2.py
04-optimisation.html  example-04.sl         matmulti3.f90
~~~

> ## Challenge
>
> Can you think of reasons why you would need to make changes to your git repository on the remote computer? How would you carry these changes over to the repository on your own computer?