Setting up an Environment
====

As a system administrator, I prefer not to have side projects' dependencies mix and potentially cause conflicts.  For this reason, all of my Python deployments are created inside a virtual environment using the standard library module `venv`.

Dependencies
----

For now, we'll create a basic virtual environment.  On Ubuntu you may need to install `python3-venv`.

```
sudo apt install python3-venv
```

Organization
----

We'll assume you're working in a directory called `projects` under your home dir.  Feel free to change this to suit your needs.  We'll create a new project called `chapter01` now.

```
mkdir ~/projects/chapter01
cd ~/projects/chapter01
```

Create your first venv
----

We're currently in the `chapter01` folder, so lets create a virtual environment for it.

```
python3 -m venv chapter01_venv
```

At this point, the virtual environment exists (you should see a folder named `chapter01_venv`) but it is not yet active.  To activate it, source the activate script in to your current shell.

```
source chapter01_venv/bin/activate
```

Your shell prompt should now include `(chapter01_venv)` at the beginning to let you know what virtual environment is active.  Any time you run the source command as above, commands like `python` and `pip` will refer to this environment when searching for or installing libraries.

To exit your current environment, you can use the `deactivate` command that was registered by the `activate` script.

Installing a library
----

Now that you have an active virtual environment, we'll install a commonly used third-party library called `requests`.

```
pip install requests
```

With requests installed, we should be able to make an example query to an external API.  This example uses a number of concepts we will cover in later chapters.

```
python
Python 3.9.5 (default, May 11 2021, 08:20:37) 
[GCC 10.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import json
>>> import requests
>>> result = requests.get("http://worldtimeapi.org/api/timezone/America/New_York")
>>> result_data = result.json()
>>> print(json.dumps(result_data, indent=4, sort_keys=True))
{
    "abbreviation": "EST",
    "client_ip": "127.35.10.5",
    "datetime": "2021-11-16T22:13:21.653503-05:00",
    "day_of_week": 2,
    "day_of_year": 320,
    "dst": false,
    "dst_from": null,
    "dst_offset": 0,
    "dst_until": null,
    "raw_offset": -18000,
    "timezone": "America/New_York",
    "unixtime": 1637090001,
    "utc_datetime": "2021-11-17T03:13:21.653503+00:00",
    "utc_offset": "-05:00",
    "week_number": 46
}
```

This example introduces the `json` library, which is frequently used for communicating with external APIs.  Typically once data is loaded from json data it will be modified before being "dumped" back in to json format, this example is using `json.dumps`'s `indent` argument to format the dictionary of data for printing.  We will cover Python data types in another chapter.

Take note that lines beginning with `>>>` are Python prompts and as such are Python code and not bash commands.

Keeping a clean and up-to-date working environment
----

The virtual environment we've created is visible in a casual file listing.  It may be more convenient for you to hide the venv's folder to reduce clutter in projects you maintain.  Additionally, we're using the versions of `pip` and other dependencies installed by the system package manager.  To address these issues we'll create our virtual environment in a folder called `.venv` and tell the venv module to upgrade dependencies when creating our new venv.

Deactivate your existing virtual environment (`deactivate` on the command line) before doing the following.

```
deactivate
python3 -m venv --upgrade-deps --prompt "chapter01" .venv
source .venv/bin/activate
```

You should now have a venv named "chapter01" activated, whose source files are in `.venv` under this project.  Some helpful bash functions are included at `supplement/venv.bash` in this repository.  You can copy this file somewhere in your home folder and source it in your `.bashrc` file to have shortcuts for making project folders with virtual environment configured (`mkvenv`), activating a project by name (`workon chapter01`), and removing virtual environment folders that are no longer needed (`rmvenv chapter01`).

```
cp ~/path/to/this/repo/supplement/venv.bash ~/.venv.bash
echo "source ~/.venv.bash" >> ~/.bashrc
```

Don't forget to close and reopen you shell after changing your `~/.bashrc` file.

Get ready for chapter02
----

Go ahead and create a new project for chapter02.

```
mkvenv chapter02
```
