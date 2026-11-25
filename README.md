# new-lg4ff-eopkg

An eopkg package for Solus that automatically builds, installs, and loads
the **new-lg4ff** kernel module.

## What does it do?

[new-lg4ff](https://github.com/berarma/new-lg4ff) is a kernel module that
provides full Linux support for Logitech steering wheels, including the
G25, G27, G29, G920, G923, and compatible models. However, the module must
be rebuilt after every kernel update, and it conflicts with the default
`hid_logitech` module.

This package solves that problem as follows:

1. **Source management** — Keeps the `new-lg4ff` repository under
   `/usr/src/new-lg4ff`; clones it on first run if it is missing.
2. **Automatic build** — Checks whether the module exists for the running
   kernel (`uname -r`) via `modinfo`; if not, builds and installs it with
   `make` and `make install`.
3. **Conflict handling** — If `/sys/module/hid_logitech` exists, unloads
   the conflicting default module with `modprobe -r`.
4. **Loading** — Loads the new driver with `modprobe hid-logitech-new`.

All of this runs automatically through a **systemd oneshot service**
(`new-lg4ff-autoload.service`) at `graphical.target`.

## Installation

Download eopkg package from releases and install it with:
```bash
sudo eopkg install new-lg4ff-*.eopkg
```
Restart the system

## Removing the package

```bash
sudo eopkg remove new-lg4ff
sudo eopkg rmo
```
