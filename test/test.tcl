# Hey Emacs, use -*- Tcl -*- mode

set thisfile [file normalize [info script]]

set test_directory [file dirname $thisfile]

set invoked_directory [pwd]

set test_directory_parts [file split $test_directory]
set package_directory [file join {*}[lrange $test_directory_parts 0 end-1]]

lappend auto_path $package_directory

proc intlist {start points} {
    # Return a list of increasing integers starting with start with
    # length points
    set count 0
    set intlist [list]
    while {$count < $points} {
	lappend intlist [expr $start + $count]
	incr count
    }
    return $intlist
}

######################## Command line parsing ########################
#
# Get cmdline from tcllib
package require cmdline

set usage "usage: [file tail $argv0] \[options]"
set options {
    {v.arg 0.0 "Version to test"}
    {n.arg "mypackage" "Name of the package"}
}

try {
    array set params [::cmdline::getoptions argv $options $usage]
} trap {CMDLINE USAGE} {message optdict} {
    # Trap the usage signal, print the message, and exit the application.
    # Note: Other errors are not caught and passed through to higher levels!
    puts $message
    exit 1
}

proc colorputs {newline text color} {

    set colorlist [list black red green yellow blue magenta cyan white]
    set index 30
    foreach fgcolor $colorlist {
	set ansi(fg,$fgcolor) "\033\[1;${index}m"
	incr index
    }
    set ansi(reset) "\033\[0m"
    switch -nocase $color {
	"red" {
	    puts -nonewline "$ansi(fg,red)"
	}
	"green" {
	    puts -nonewline "$ansi(fg,green)"
	}
	"yellow" {
	    puts -nonewline "$ansi(fg,yellow)"
	}
	"blue" {
	    puts -nonewline "$ansi(fg,blue)"
	}
	"magenta" {
	    puts -nonewline "$ansi(fg,magenta)"
	}
	"cyan" {
	    puts -nonewline "$ansi(fg,cyan)"
	}
	"white" {
	    puts -nonewline "$ansi(fg,white)"
	}
	default {
	    puts "No matching color"
	}
    }
    switch -exact $newline {
	"-nonewline" {
	    puts -nonewline "$text$ansi(reset)"
	}
	"-newline" {
	    puts "$text$ansi(reset)"
	}
    }

}

proc listns {{parentns ::}} {
    set result [list]
    foreach ns [namespace children $parentns] {
        lappend result {*}[listns $ns] $ns
    }
    return $result
}

proc fail_message { message } {
    # Print a fail message
    puts -nonewline "\["
    colorputs -nonewline "fail" red
    puts -nonewline "\] "
    puts $message
}

proc pass_message { message } {
    # Print a pass message
    puts -nonewline "\["
    colorputs -nonewline "pass" green
    puts -nonewline "\] "
    puts $message
}

proc info_message { message } {
    # Print an informational message
    puts -nonewline "\["
    colorputs -nonewline "info" blue
    puts -nonewline "\] "
    puts $message
}

proc indented_message { message } {
    # Print a message indented to the end of a pass/fail block
    foreach character [intlist 0 7] {
	puts -nonewline " "
    }
    puts $message
}


proc test_require_tin {} {
    # Test if Tin is installed
    info_message "Test Tin installation"
    try {
	set version [package require tin]
    } trap {} {message optdict} {
	fail_message "Failed to load Tin package"
	indented_message "$message"
	exit
    }

    pass_message "Loaded Tin version $version"
    set action_script [package ifneeded tin $version]
    indented_message "Action script is:"
    foreach line [split $action_script "\n"] {
	indented_message $line
    }
    return
}

proc test_require_package {} {
    # Test requiring the package and the package version
    global params
    info_message "Test loading package"
    try {
	set version [package require -exact $params(n) $params(v)]
    } trap {} {message optdict} {
	fail_message "Failed to load $params(n) package"
	indented_message "$message"
	exit
    }
    if {$version eq $params(v)} {
	pass_message "Loaded $params(n) version $version"
	set action_script [package ifneeded $params(n) $version]
	indented_message "Action script is:"
	foreach line [split $action_script "\n"] {
	    indented_message $line
	}
	return
    } else {
	fail_message "Failed to load correct $params(n) version"
	indented_message "Expected $params(v), got $version"
	exit
    }
}

proc test_intlist_length { length } {
    # Test the length of the list produced with intlist
    # Arguments:
    #   length -- Target length
    info_message "Test length of list made by intlist"
    set output_list [::testin::intlist -length $length]
    if { [llength $output_list] == $length } {
	pass_message "intlist length is correct"
	return
    } else {
	fail_message "Expected length of $length, got [llength $output_list]"
	exit
    }
}

########################## Main entry point ##########################

test_require_package

test_intlist_length 5

