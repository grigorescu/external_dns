##! This is processed when a user explicitly loads the plugin's script module
##! through `@load NCSA/external_dns`.
##! Include code here that should execute at that point.
##!
##! This is the most common entry point to your plugin's accompanying scripts.
##!
##! File load order, always happens
##!   1. Zeek startup
##!   2. Plugin activation
##!   3. __preload__.zeek always gets loaded
##!   4. __load__.zeek always gets loaded
##!
##! ONLY IF the plugin gets loaded via `@load NCSA/external_dns`, this continues:
##!   5. @load NCSA/external_dns/__load__.zeek <-- YOU ARE HERE

@load ./main
