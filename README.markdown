# Testin: Testing the Tin Tcl Package Manager #

Test package for the [Tin](https://github.com/ambaker1/Tin) Tcl
package manager.  Tin allows easy installation of
[Github](https://github.com/)-based [Tcl](https://www.tcl.tk/about/language.html) packages.

![Tin can](img/tin_can_150.png)

[Image by upklyak on Freepik](https://www.freepik.com/author/upklyak)

## Installing Tin ##

Follow the instructions at the [Tin repository](https://github.com/ambaker1/Tin) to install Tin.

## Installing Tcllib ##

[Tcllib](https://www.tcl.tk/software/tcllib/) provides many packages needed for Tcl development, including [cmdline](https://core.tcl-lang.org/tcllib/doc/trunk/embedded/md/tcllib/files/modules/cmdline/cmdline.md) for handling command-line options.  Testin uses cmdline for named function arguments.

### Linux ###

If you have [apt](https://ubuntu.com/server/docs/package-management) for Linux, installing is as easy as

```
apt install tcllib
```

...and Tcllib is installed in `usr/share/tcltk/tcllib1.20` on my system.  Make sure the [TCLLIBPATH](https://wiki.tcl-lang.org/page/TCLLIBPATH) environment variable (list, actually) contains your installation path.  I set this in my `.emacs` file with

```
;; Ubuntu installs tcllib and tklib packages in /usr/share/tcltk
;;
;; sudo apt install tcllib
(setenv "TCLLIBPATH"
	(string-join '("/usr/share/tcltk/tcllib1.20"
		       "/usr/share/tcltk/tklib0.7"
		       "/usr/lib/tcltk/sqlite3"
		       "/usr/local/share/tcltk")
		     " "))
```

...so that I can `M-x run-tcl` inside [Emacs](https://www.gnu.org/software/emacs/).

### Windows ###

I usually just manually copy Tcllib into the `lib` directory of my Tcl installation on Windows.  I then have a similar command in my `.emacs` file:

```
(setenv "TCLLIBPATH"
	(string-join '("c:/Program Files/Tcl86/lib/tcllib1.20"
		       "c:/Program Files/Tcl86/lib/"
		     " "))
```

...so I can run Tcl the same way on both platforms.



