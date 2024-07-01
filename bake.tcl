# Hey Emacs, use -*- Tcl -*- mode

package require cmdline
package require tin


set usage "usage: [file tail $argv0] \[options]"
set options {
    {v.arg 1.0 "Version code"}
}

try {
    array set params [::cmdline::getoptions argv $options $usage]
} trap {CMDLINE USAGE} {message optdict} {
    # Trap the usage signal, print the message, and exit the application.
    # Note: Other errors are not caught and passed through to higher levels!
    puts $message
    exit 1
}

tin bake src . "VERSION $params(v)"
