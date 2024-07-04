
set libdir [info library]
set libdir_parts [file split $libdir]

# The default directory for packages is one directory up from [info library]
set package_directory [file join {*}[lrange $libdir_parts 0 end-1]]
puts $package_directory
