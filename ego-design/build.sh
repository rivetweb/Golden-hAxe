#NOTE this project work only on haxe version 2.05 :]
HAXEPATH="c:/bin/haxe2_05"
NEKO_INSTPATH="c:/bin/haxe2_05"

$HAXEPATH/haxe -as3 as3_src -cp src -main Main -lib feffects

#fix compiling bug
sed -i 's/}null{/};null;{/g' as3_src/flash/Boot.as
