# path
$env.PATH = ($env.PATH | prepend "/opt/homebrew/bin")

# init
$env.config.show_banner = false
$env.config.edit_mode = "vi"

# scripts
const scripts = {
  starship: ($nu.data-dir | path join scripts starship.nu)
  carapace: ($nu.data-dir | path join scripts carapace.nu)
  zoxide: ($nu.data-dir | path join scripts zoxide.nu)
}

# carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
carapace _carapace nushell | save --force $scripts.carapace
source $scripts.carapace

# starship
starship init nu | save -f $scripts.starship
source $scripts.starship

# zoxide
zoxide init nushell | save -f $scripts.zoxide
source $scripts.zoxide
