{CompositeDisposable} = require 'atom'

module.exports = Sashisuseso =

    activate: (state) ->
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace', 'sashisuseso:toggle': => @toggle()
        @setup()

    setup: ->
        @editor = atom.workspace.getActiveTextEditor()
        @editor.getBuffer().onDidChange @onChange.bind(this)

        @audios = []
        @audios[0] = new Audio("atom://sashisuseso/sound/sa.mp3")
        @audios[1] = new Audio("atom://sashisuseso/sound/shi.mp3")
        @audios[2] = new Audio("atom://sashisuseso/sound/su.mp3")
        @audios[3] = new Audio("atom://sashisuseso/sound/se.mp3")
        @audios[4] = new Audio("atom://sashisuseso/sound/so.mp3")

        for i in [0..4]
            @audios[i].autoplay = false

    onChange: (e) ->
        if e.newText is "\n"
            @audios[Math.floor(Math.random() * 5)].play()

    toggle: ->
        console.log 'Sashisuseso was toggled!'
