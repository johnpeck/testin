# Hey Emacs, use -*- Tcl -*- mode

package require tin 1.0

set dir [tin mkdir -force testin 1.2]
file copy testin.tcl $dir
file copy pkgIndex.tcl $dir
