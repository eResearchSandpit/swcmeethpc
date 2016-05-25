# Working on a remote computer

High performance computers are usually housed in a data centre and consist of a number of racks full of individual compute servers that are cooled by noisy fans. No user will get direct physical access to these computers systems, we will therefore have to connect to them using a network and use programs for remote access.

The `ssh` (Secure Shell) prgram has become very popular, allowing users to "remote control" a computer using the same (or similar) shell that they use on their local computer. All data transfer is encrypted, `ssh` can therefore be used on any public network.

Before we can connect to a remote computer, we first need to get access by asking a system administrator for a user account. Once the account has been created, the system administrator will provide a user name and password, or will ask for the public key of a key pair that was generated with `ssh-keygen`.

We can now open a terminal (Git Bash for Windows users) and type the following command, replacing "user" with the account name given to you:
```{bash}
$ ssh user@login.uoa.nesi.org.nz
```
~~~ {.output}

      *******************************************************************
      **         Welcome to Pan, the NeSI Intel x86-64 Cluster         **
      **                                                               **
      **  This high-performance computing cluster is operated by the   **
      **  University of Auckland Centre for eResearch as part of the   **
      **             New Zealand eScience Infrastructure.              **
      **                                                               **
      *******************************************************************

      For a list of your current projects, run show_my_projects.
      To see your current quota usage, run fs_my_quota_usage.

      For documentation, visit https://wiki.auckland.ac.nz/x/CA-sAg.

      To build or test software, use one of the build nodes:
                ssh build-wm (Westmere)
                ssh build-sb (SandyBridge)

[user@login-01 ~]$
~~~
Depending on account setup, `ssh` will ask for a password, or it can even log in without a password if our public key file has been installed on the remote computer by the system administrator. If everything goes well, the remote computer will greet us with a welcome message and some general information.

> ## Warning message about host authenticity
> When you connect to a remote computer for the first time with `ssh`, you should see a warning message:
>
> ~~~ {.output}
> The authenticity of host 'login.uoa.nesi.org.nz (130.216.161.186)' can't be established.
> RSA key fingerprint is [...]
> Are you sure you want to continue connecting (yes/no)?
> ~~~
>
> This is a security warning - if you want to be sure that you are indeed connecting to the computer "login.uoa.nesi.org.nz", you will need to verifying the key fingerprint with a system administrator. If you are satisfied that everything is correct, confirm by typing *yes*.

We now no longer operate our own computer - `ssh` allows us to control the remote computer "login.uoa.nesi.org.nz" using the exact same commands as we would use on our own computer. Let's try to find out who we are, as we did in the shell session:
```{bash}
[user@login-01 ~]$ whoami
```
~~~ {.output}
user
~~~
Depending on the quality of your network connection and the geographical distance to the remote computer, you might notice some delays in the response from the remote computer.

We can ask the remote computer for its name:
```{bash}
[user@login-01 ~]$ uname -n
```
~~~ {.output}
login-01.uoa.nesi.org.nz
~~~

Let's check where we are:
```
[user@login-01 ~]$ pwd
```
~~~ {.output}
/home/user
~~~
This will probably give a different answer than running the same command on our own computer - we are now using the file system of the remote machine.

Let's get a list of all files in our current working directory:
```{bash}
[user@login-01 ~]$ ls
```
This should produce no output - our account is new and we haven't done anything yet.

To keep things tidy, we will first create a new work directory:
```{bash}
[user@login-01 ~]$ mkdir matmul
```

As expected, a new directory appears:
```{bash}
[user@login-01 ~]$ ls
```
~~~ {.output}
matmul
~~~

We can leave the remote computer again by using the `exit` command:
```{bash}
[user@login-01 ~]$ exit
```
~~~ {.output}
logout
Connection to login.uoa.nesi.org.nz closed.
~~~

We are now back on our own computer:
```{bash}
$ uname -n
```
~~~ {.output}
mylaptop
~~~

The name will depend on your computer setup.

> ## Challenge
> User "nelle" wants to connect to "login.uoa.nesi.org.nz" and remotely create a directory called "hpc_project" and a text file "README" inside the new directory. Which of the following solutions are correct?
>
> 1.
>
> ```{bash} 
> $ mkdir hpc_project
> $ nano hpc_project/README
> $ ssh nelle@login.uoa.nesi.org.nz
> ```
>
> 2.
>
> ```{bash} 
> $ ssh nelle@login.uoa.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
>
> 3.
>
> ```{bash} 
> $ ssh login.uoa.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
>
> 4.
>
> ```{bash} 
> $ ssh nelle@login.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
