# Creating ssh keypairs

Connecting to a remote computer using "Secure Shell" (`ssh`) requires authentication, allowing the remote computer to verify that a user does indeed have access to the system. Besides using simple passwords, `ssh` users can also create cryptographic keypairs and use these to prove their identity.

The idea behind cryptographic keypairs is that the user owns two keys, a public key and a private key, which are associated to each other. The public key can be used to encrypt a message, and only the holder of the private key can decrypt it again and understand its content. The public key is handed out to the system administrator for installation on the remote computer, while the private key stays on the user's computer and is never handed out. When the user tries to log on to the remote computer, the remote computer will use the user's public key to encrypt a message and send it to the user's computer. Only the user's private key will be able to decrypt it and thus prove the key holder's identity.

The Wikipedia articles on [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell) and [public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography) provide further information about this topic. 

In order to create a cryptographic keypair, open a terminal (Git Bash for Windows users) and run the following command:
```
$ ssh-keygen -t rsa -b 4096 -C "user_email@example.com"
```
The keypair generator will ask for a file path for the keypair (just hit return to accept the default path) and for a password (hit return if you want to allow passwordless key usage).

> ## Passwordless keys
>
> Be careful when using passwordless keys! This means that anyone with access to your computer will also have access to the remote computer!

The keys are stored in the hidden ".ssh" directory:
```
$ ls ~/.ssh
```
~~~ {.output}
id_rsa  id_rsa.pub
~~~
The first file "id\_rsa" contains the private key, while the second file "id\_rsa.pub" contains the public key that can be handed out.
