# Hey Emacs, use -*- Tcl -*- mode

if {![package vsatisfies [package provide Tcl] 8.6]} {return}
package ifneeded testin 1.1 [list source [file join $dir testin.tcl]]
