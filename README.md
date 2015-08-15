# highlight-quoted-vars.el

This program allows you to easily recognize when a variable is being
interpolated in Strings without having to guess.

For example:

    "$HOME will be highlighted while \$thisVar will not be"
    'Any $Vars will NOT be highlighted in $single quotes'

To use this software, add a variation of the following code to one
of your init files (`$HOME/.emacs.d/init.el`, or `$HOME/.emacs`):

    (add-hook 'sh-mode-hook 'sh-script-extra-font-lock-activate)
