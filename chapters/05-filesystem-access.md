Filesystem Access
====

When administering systems with Python scripts, you will likely need to interact with the filesystem, potentially traversing entire filesystem trees and performing operations for files.  This chapter covers some common filesystem operations.


File management
----

In earlier versions of Python, the `os` module was the primary interface for interacting with filesystems and paths.  The `os` module provides tools for removing, changing ownership on files, and other common operating system tasks.  Modern Python (since v3.4) includes a new module named `pathlib` that provides a more Pythonic file interface.  We will only use `os` here where `pathlib` has no analog.

A common use-case is creating and removing files and folders.  The simplest way to create a file is by opening it for writing/appending.  This is inefficient, as `pathlib` provides a `touch` method to do this for you.

```
>>> import pathlib
>>> file = pathlib.Path('touch.example')
>>> file.exists()
False
>>> file.touch()
>>> file.exists()
True
>>> file.unlink()
>>> file.exists()
False
```

You may also need to see the contents of a directory.

```
>>> here = pathlib.Path.cwd()
>>> here
PosixPath('/home/redkrieg/projects/p4sa')
>>> for file in here.iterdir():
...     print(f"{'d' if file.is_dir() else '-'} {file.owner()} {file.group()} {file.stat().st_size} {file.name}")
... 
d redkrieg redkrieg 4096 chapters
d redkrieg redkrieg 4096 supplement
- redkrieg redkrieg 283 newfile.txt
- redkrieg redkrieg 162 README.md
d redkrieg redkrieg 4096 .venv
```

Print just the files matching a pattern.

```
>>> for file in sorted(here.glob('chapters/*.md')):
...     print(file.name)
... 
00-introduction.md
01-setting-up-an-environment.md
02-types-of-data.md
03-iteration.md
04-classes.md
05-filesystem-access.md
06-running-programs.md
07-serializing-data.md
08-making-http-requests.md
09-building-an-api-client.md
10-database-access.md
```

We can also work with symbolic links.

```
>>> rwfilelink = pathlib.Path('rwfile.link')
>>> rwfilelink.symlink_to(rwfile)
>>> rwfilelink.resolve()
PosixPath('/home/redkrieg/projects/p4sa/rwfile.txt')
>>> rwfilelink.stat().st_size
93
>>> rwfilelink.lstat().st_size
10
>>> rwfilelink.is_file()
True
>>> rwfilelink.is_symlink()
True
```

Changing file modes and ownership is another possibility.  Note only root can change file owners (chown) under normal circumstances.  Pathlib does not have a chown function so we will import `shutil` for this.

```
sudo python3
Python 3.9.5 (default, May 11 2021, 08:20:37) 
[GCC 10.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pathlib
>>> import shutil
>>> rwfile = pathlib.Path('rwfile.txt')
>>> rwfile.chmod(0o400) # use octal for permissions
>>> oct(rwfile.stat().st_mode)
'0o100400'
>>> shutil.chown(rwfile, 'root', 'root')
>>> rwfile.owner()
'root'
>>> exit()
```

In general, you should not run your scripts as the root user, so be sure to `exit()` your shell after the above example and resume with a normal Python interpreter.

The previous example introduced the `shutil` library, which contains some helpers for high-level filesystem operations.  This includes copying all files in a path to another path, recursively removing a directory and its children, and archiving files in tar or zip archives. See [the shutil documentation](https://docs.python.org/3/library/shutil.html) for more examples.

Reading and writing files
----

To read and write files, you must first `open` them.  The `open` function built in to Python which is used for creating a file handle as an I/O stream (just like in the `io` built in module).  When opening files you can open them for reading, writing, and as a text or binary file using the `mode` argument.

```
>>> import pathlib
>>> file_path = pathlib.Path('newfile.txt')
>>> file = open(file_path, mode='w')
>>> file.write("This will be on the first line")
30
>>> file.write("This will also be on the first line, because there is no prior newline, unlike at the end of this string.\n")
106
>>> file.write("The numbers you see are the number of bytes written.\n")
53
>>> file.close()
>>> file = open(file_path, mode='r')
>>> print(file.read())
This will be on the first lineThis will also be on the first line, because there is no prior newline, unlike at the end of this string.
The numbers you see are the number of bytes written.

>>> file.close()
```

While it is possible to explicitly close these streams, it is generally preferable to access files from within a context manager using the `with` keyword.

```
>>> with open(newfile, mode='a') as file: #open in append mode
...     file.write('This is a new line appended to the file.\n')
... 
41
>>> with open(newfile, mode='r') as file:
...     print(file.read())
... 
This will be on the first lineThis will also be on the first line, because there is no prior newline, unlike at the end of this string.
The numbers you see are the number of bytes written.
This is a new line appended to the file.

```

You should always close streams that you do not open `with` a context manager.  Most operating systems have sensible limits on the number of open files a process can access and failure to close file handles can cause issues with long term stability.

For small text files, you may use `read_text` and `write_text`.  Here we use triple quotes for multi-line input.

```
>>> rwfile = pathlib.Path('rwfile.txt')
>>> rwfile.write_text("""This can be especially handy for saving serialized data.
... We'll use it again in a later chapter
... """)
93
>>> print(rwfile.read_text())
This can be especially handy for saving serialized data.
We'll use it again in a later chapter.
```

You can also iterate over each line of a file using a `for` loop.

```
>>> with open(rwfile) as file:
...     for i, line in enumerate(file):
...         print(f"Line {i}: {line.strip()}")
... 
Line 0: This can be especially handy for saving serialized data.
Line 1: We'll use it again in a later chapter
```

Note in the above example that `strip()` removes newlines and whitespace from the beginning and end of each line.
