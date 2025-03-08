# Hey Emacs, use -*- Tcl -*- mode

package require tin 2.1

set dir [tin mkdir -force testin 1.4]
file copy testin.tcl $dir
file copy pkgIndex.tcl $dir
