{
  "$mod" = "SUPER";
  bind = [
    "$mod, F, exec, firefox"
    ", Print, exec, grimblast copy area"
  ] 
  ++ (
    builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
	"$mod, code:1${toString i}, workspace, ${toString ws}"
	"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      ]
    ) 9)
  );
}
