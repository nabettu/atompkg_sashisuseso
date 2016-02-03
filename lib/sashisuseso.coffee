{CompositeDisposable} = require 'atom'

module.exports = Sashisuseso =
    active: false
    activate: (state) ->
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.commands.add 'atom-workspace', 'sashisuseso:toggle': => @toggle()
        @setup()

        @activeItemSubscription = atom.workspace.onDidChangeActivePaneItem =>
            @setup()

    destroy: ->
        @activeItemSubscription?.dispose()

    setup: ->
        @editor = atom.workspace.getActiveTextEditor()
        @editorChangeSubscription?.dispose()
        @editorChangeSubscription = @editor.getBuffer().onDidChange @onChange.bind(this)

        @audios = []
        @audios[0] = new Audio("atom://sashisuseso/sound/sa.mp3")
        @audios[1] = new Audio("atom://sashisuseso/sound/shi.mp3")
        @audios[2] = new Audio("atom://sashisuseso/sound/su.mp3")
        @audios[3] = new Audio("atom://sashisuseso/sound/se.mp3")
        @audios[4] = new Audio("atom://sashisuseso/sound/so.mp3")
        for i in [0..4]
            @audios[i].autoplay = false
        @beforeNum = 0

    onChange: (e) ->
        return if not @active
        if e.newText is "\n"
            @ranNum = Math.floor(Math.random() * 5)
            while @ranNum == @beforeNum
                @ranNum = Math.floor(Math.random() * 5)
            @beforeNum = @ranNum
            @audios[@ranNum].play()

    toggle: ->
        @active = not @active
        if @active
          console.log 'Sashisuseso is on'
        else
          console.log 'Sashisuseso is off'
