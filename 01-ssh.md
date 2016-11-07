# Working on a remote computer

High performance computers are usually housed in a data centre and consist of a number of racks full of individual compute servers that are cooled by noisy fans. No user will get direct physical access to these computers systems, we will therefore have to connect to them using a network and use programs for remote access.

The `ssh` (Secure Shell) prgram has become very popular, allowing users to "remote control" a computer using the same (or similar) shell that they use on their local computer. All data transfer is encrypted, `ssh` can therefore be used on any public network.

Before we can connect to a remote computer, we first need to get access by asking a system administrator for a user account. Once the account has been created, the system administrator will provide a user name and password, or will ask for the public key of a key pair that was generated with `ssh-keygen`.

We can now open a terminal (Git Bash for Windows users) and type the following command, replacing "user" with the account name given to you:
```{bash}
$ ssh user@fitzroy.nesi.org.nz
```
~~~ {.output}
    __  _   __ _   _   __  __
   /  |/ / / /| | / | / / /  |  National Institute of
  /  |  / / / | |/ /|/ / / / |  Water and Atmospheric
 /__/|_/ /_/  |_/_/ |_/ /_/|_|  Research Ltd


  By using this this computer system you accept and agree to the NIWA IT security and usage policies.
  To ensure compliance with legal requirements and to maintain cyber security standards,
  NIWAs IT systems are subject to ongoing monitoring, activity logging and auditing.
  This monitoring and auditing service may be provided by third parties.
  Such third parties can access information transmitted to, processed by and stored on NIWA's IT systems.

Documentation:
  Fitzroy documentation is available here: https://teamwork.niwa.co.nz/x/NwGP

Support:
  NeSI website: https://support.nesi.org.nz
  by email to fitzroy@nesi.org.nz

Quota:
  [home]        17535 files    5GB / 100GB     5.07%
-bash-4.2$
~~~
Depending on account setup, `ssh` will ask for a password, or it can even log in without a password if our public key file has been installed on the remote computer by the system administrator. If everything goes well, the remote computer will greet us with a welcome message and some general information.

> ## Warning message about host authenticity
> When you connect to a remote computer for the first time with `ssh`, you should see a warning message:
>
> ~~~ {.output}
> The authenticity of host 'fitzroy.nesi.org.nz (202.36.29.80)' can't be established.
> ECDSA key fingerprint is SHA256:3FRdou5588zzSw6du2YfNYeASFSx3y4seMVtqTPhjPg.
> Are you sure you want to continue connecting (yes/no)?
> ~~~
>
> This is a security warning - if you want to be sure that you are indeed connecting to the computer "fitzroy.nesi.org.nz", you will need to verify the key fingerprint with a system administrator. If you are satisfied that everything is correct, confirm by typing *yes*.

We now no longer operate our own computer - `ssh` allows us to control the remote computer "fitzroy.nesi.org.nz" using the exact same commands as we would use on our own computer. Let's try to find out who we are, as we did in the shell session:
```{bash}
-bash-4.2$ whoami
```
~~~ {.output}
user
~~~
Depending on the quality of your network connection and the geographical distance to the remote computer, you might notice some delays in the response from the remote computer.

We can ask the remote computer for its name:
```{bash}
-bash-4.2$ uname -n
```
~~~ {.output}
nesi1
~~~

We can also ask which operating system the remote computer is running and which processor architecture it uses:
```{bash}
-bash-4.2$ uname -sp
```
~~~ {.output}
AIX powerpc
~~~
Fitzroy runs on AIX, which is a UNIX variant and very similar to Linux - but not the same, which means that some things work differently compared to Linux. The POWER microprocessor architecture is also a bit different from the x86_64 microprocessor architecture which is mostly used in PCs and laptops, which means that software that runs on a PC will not run on the HPC and vice versa. We can nonetheless run things like Python or R programs on either type of computer.

Let's check where we are:
```
-bash-4.2$ pwd
```
~~~ {.output}
/home/user
~~~
This will probably give a different answer than running the same command on our own computer - we are now using the file system of the remote machine.

Let's get a list of all files in our current working directory:
```{bash}
-bash-4.2$ ls
```
This should produce no output - our account is new and we haven't done anything yet.

To keep things tidy, we will first create a new work directory:
```{bash}
-bash-4.2$ mkdir matmul
```

As expected, a new directory appears:
```{bash}
-bash-4.2$ ls
```
~~~ {.output}
matmul
~~~

We can leave the remote computer again by using the `exit` command:
```{bash}
-bash-4.2$ exit
```
~~~ {.output}
logout
Connection to fitzroy.nesi.org.nz closed.
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
> User "nelle" wants to connect to "fitzroy.nesi.org.nz" and remotely create a directory called "hpc_project" and a text file "README" inside the new directory. Which of the following solutions are correct?
>
> 1.
>
> ```{bash} 
> $ mkdir hpc_project
> $ nano hpc_project/README
> $ ssh nelle@fitzroy.nesi.org.nz
> ```
>
> 2.
>
> ```{bash} 
> $ ssh nelle@fitzroy.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
>
> 3.
>
> ```{bash} 
> $ ssh fitzroy.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
>
> 4.
>
> ```{bash} 
> $ ssh nelle@login.fitzroy.nesi.org.nz
> $ mkdir hpc_project
> $ nano hpc_project/README
> ```
