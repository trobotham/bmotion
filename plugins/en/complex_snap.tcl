## bMotion plugin: blblbl
#
# $Id$
#


###############################################################################
# This is a bMotion plugin
# Copyright (C) James Michael Seward 2000-2002
#
# This program is covered by the GPL, please refer the to LICENCE file in the
# distribution; further information can be found in the headers of the scripts
# in the modules directory.
###############################################################################

bMotion_plugin_add_complex "snap" "." 100 bMotion_plugin_complex_snap "en"

proc bMotion_plugin_complex_snap { nick host handle channel text } {
  bMotion_flood_undo $nick

  if {[string length $text] < 5} {
    return 0
  }
  if {($text == [bMotion_plugins_settings_get "complex:snap" $channel "" "text"]) &&
      ($nick != [bMotion_plugins_settings_get "complex:snap" $channel "" "nick"])} {
        if {[bMotion_interbot_me_next $channel] && [rand 3]} {
          set othernick [bMotion_plugins_settings_get "complex:snap" $channel "" "nick"]
          putlog "othernick = $othernick"
          bMotionDoAction $channel $nick "%VAR{snaps}" $othernick
          bMotion_plugins_settings_set "complex:snap" $channel "" "text" ""
          bMotion_plugins_settings_set "complex:snap" $channel "" "nick" ""
        }
      }
  bMotion_plugins_settings_set "complex:snap" $channel "" "text" $text
  bMotion_plugins_settings_set "complex:snap" $channel "" "nick" $nick
  return 0
}

bMotion_abstract_register "snaps"
bMotion_abstract_batchadd "snaps" [list "o snap" "SNAP" "SNAP!" "/wins %% and %2"]
