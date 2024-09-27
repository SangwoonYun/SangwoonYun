# How to install python3.12


### Add apt repository for python
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.12
```

### Alternative version
```bash
sudo update-alternatives --config python
```

if you see `update-alternatives: error: no alternatives for python`, try below

```bash
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1
# Proceed for all installed Python versions.
# However, modify the last priority.
update-alternatives --config python
```

```bash
$ sudo update-alternatives --config python
There are 2 choices for the alternative python (providing /usr/bin/python).

  Selection    Path                Priority   Status
------------------------------------------------------------
* 0            /usr/bin/python3.8   2         auto mode
  1            /usr/bin/python3.12  1         manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
```
