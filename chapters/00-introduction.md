Introduction
====

Python is a powerful and versatile language with a "batteries included" attitude toward the standard library.  This means that a basic Python installation has at least basic tools to interact with the world already included.  We'll be using these as well as third-party libraries here.  Only Python 3 will be used here.

It is assumed that you have some basic understanding of Python syntax.  This tutorial's chapters will show useful examples for system administrators but are by no means the only way to accomplish the same tasks.  Explore the standard library and third party libraries available over the internet.

You should also be familiar with the Linux command line environment concepts of file management, package installation, and basic shell interaction.  We will cover virtual environments and installing packages via pip, which will minimize the effects on your system.

The examples will be based on Ubuntu systems where the distribution is relevant.  If you have changes to make for your distro of choice, please submit a pull request.

Getting Help
====

Sometimes you need additional information to help you learn more about something.  The `help()` function in Python is a powerful tool for learning what arguments are available and often how to use a function.  Use it on every new module and function you see!  If you need more information, the (Python standard library documentation](https://docs.python.org/3/library/index.html) often has examples for each tool available.

```
>>> import pathlib
>>> help(pathlib)
# try this yourself!
>>> help(pathlib.Path.mkdir)
Help on function mkdir in module pathlib:

mkdir(self, mode=511, parents=False, exist_ok=False)
    Create a new directory at this given path.
```
