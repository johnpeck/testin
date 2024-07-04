
# Output package name (no extension)
#
# This will also be the namespace exported by the package
#
# Naming convention:
#   1. Can not start with a capital letter
#   2. Can not start or end with numbers
package_name = testin

# See the package man page for version number requirements:
# https://www.tcl-lang.org/man/tcl/TclCmd/package.htm
#
# Tin allows two digits: major.minor
version = 1.3

######################## End of Configuration ########################


usage_text_width = 20
indent_text_width = 15
target_text_width = 15

# All these printf statements look confusing, but the idea here is to
# separate the layout from the content.  Always use the same printf
# line with a continuation character at the end.  Put your content on
# the next line.

# Default target.
help:
	@echo "Makefile for $(package_name)"
	@printf "%$(indent_text_width)s %-$(target_text_width)s %s\n" \
          "make" "bake" \
          "Create tcl files from tin templates for version $(version)"
	@printf "%$(indent_text_width)s %-$(target_text_width)s %s\n" \
          "make" "test" \
          "Test package"
	@printf "%$(indent_text_width)s %-$(target_text_width)s %s\n" \
          "(sudo) make" "install" \
          "Install package into $(shell tclsh libloc.tcl)"
	@printf "%$(indent_text_width)s %-$(target_text_width)s %s\n" \
          "make" "clean" \
          "Remove generated files"

.PHONY: bake
bake:
	tclsh bake.tcl -v $(version)

.PHONY: install
install:
	tclsh install.tcl


.PHONY: test
test:
	tclsh test/test.tcl -n $(package_name) -v $(version)
