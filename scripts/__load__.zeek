##! This is loaded automatically at Zeek startup once the plugin gets activated
##! and its BiF elements have become available.
#
##! File load order, always happens
##!   1. Zeek startup
##!   2. Plugin activation
##!   3. __preload__.zeek always gets loaded
##!   4. __load__.zeek always gets loaded <-- YOU ARE HERE
##!
##! ONLY IF the plugin gets loaded via `@load NCSA/external_dns`, this continues:
##!   5. @load NCSA/external_dns/__load__.zeek
##!
# Include code here that should always execute unconditionally when your plugin gets activated.
#
# Note that often you may want your plugin's accompanying scripts not here, but
# in scripts/NCSA/external_dns/__load__.zeek.
# That's processed only on explicit `@load NCSA/external_dns`.
