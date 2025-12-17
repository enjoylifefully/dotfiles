alias vim = nvim

$env.config.table.mode = "single"

$env.config.keybindings ++= [{
    name: vi_shiftenter
    modifier: shift
    keycode: enter
    mode: vi_insert
    event: { edit: insertnewline }
}, {
    name: vi_o
    modifier: none
    keycode: char_o
    mode: vi_normal
    event: [{ edit: movetoend } { edit: insertnewline } { send: vichangemode mode: insert }]
}]
