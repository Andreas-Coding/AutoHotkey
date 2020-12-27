/**
    * Class: iOSVSliderProvider
    *   provider for an iOS alike styled volume slider
    *   include this within your own script for it to use this lib
    * Attributes:
    *   
    * Methods:
    *   initialize()
    * Dependencies:
    *   VSliderGUI.ahk    – Class used to manage individual slider guis
    *   Segoe MDL2 Asstes – font used for rendering icons only available in Win10+
*/
Class iOSVSliderProvider {


    initialize(configPath := "volSliderConf.json"){
        this.slider := {}
        this.slider.normal := new VSliderGUI("nSlider" ; guiName
                                                , 322 ; width
                                                , 98 ; height
                                                , 48 ; tsize
                                                , 24 ; iconOffsetx
                                                , 16 ; iconOffsety
                                                , 48 ; bradius
                                                , "Center" ; y
                                                , 224 ; transtarget
                                                , 1500) ; timeToDecay
        this.slider.fullscreen := new VSliderGUI("fcSlider" ; guiName
                                                , 192 ; width
                                                , 50 ; height
                                                , 24 ; tsize
                                                , 16 ; iconOffsetx
                                                , 8 ; iconOffsety
                                                , 24 ; bradius
                                                , 80 ; y
                                                , 208 ; transtarget
                                                , 1000) ; timeToDecay
    }


    volUp(individually, repeated, maxDiffRepeat){
        this._setVol(Format("+{1:d}"
                , this._chooseRepeated(individually
                                , repeated
                                , maxDiffRepeat)))
        this._chooseVariant()
    }


    volDown(individually, repeated, maxDiffRepeat){
        this._setVol(Format("-{1:d}"
                , this._chooseRepeated(individually
                                , repeated
                                , maxDiffRepeat)))
        this._chooseVariant()
    }


    _chooseRepeated(individually, repeated, maxTime){
        return, ((A_TimeSincePriorHotkey - A_TimeSinceThisHotkey <= maxTime) 
                    && (A_ThisHotkey == A_PriorHotkey))
                ? individually : repeated
    }


    volMute(){
        this._setMute()
        this._chooseVariant()
    }


    _setVol(vol, component := "MASTER"){
        SoundSet, vol, % component, % "VOL"
    }


    _getVol(component := "MASTER"){
        SoundGet, vol, % component, % "VOL"
        return, Round(vol)
    }


    _setMute(action := "toggle", component := "MASTER"){
        SoundSet, % (action == "mute")
                    ? 1 : (action == "unmute")
                        ? 0 : "+1"
                , % component
                , % "MUTE"
    }


    _getMute(component := "MASTER"){
        SoundGet, muteState, % component, % "MUTE"
        return, muteState
    }


    _getIcon(component := "MASTER"){
        if(this._getMute(component) != "Off")
            return, ""
        
        vol := this._getVol(component)

        if(vol < 1)
            return, ""
            
        if(vol < 33)
            return, ""
            
        if(vol < 66)
            return, ""

        return, ""
    }


    _alert(){
        MsgBox, [ Options, Title, Text, Timeout]
    }


    _chooseVariant(){
        if(!(variant := this._getVariant()))
            return
        
        if(variant == "fullscreen")
            return, this.slider.fullscreen.update(this._getVol(), this._getIcon())

        if(variant != "normal")
            return, this._alert("Yet not chooseable userinterface variant")
            
        return, this.slider.normal.update(this._getVol(), this._getIcon())
    }


    _getVariant(){
        atts := this._winGetAttributes("A")
        if((atts.class == "Windows.UI.Core.CoreWindow")
                || (atts.class == "WorkerW"))
            return, "normal"

        if((atts.width == A_ScreenWidth)
                && (atts.height == A_ScreenHeight))
            return, "fullscreen"

        return, "normal"
    }


    _getWinAttributes(title){
        r := {}

        WinGetTitle, t, % title
        r.title := t

        WinGetClass, c, % title
        r.class := c

        for _, element in ["ID", "PID", "ProcessName", "ProcessPath"] {
            WinGet, out, % element, % title
            r[element] := out
        }

        r.dim := {}
        WinGetPos, x, y, width, height, % title
        r.dim.x := x
        r.dim.y := y
        r.dim.width := width
        r.dim.height := height

        return, r
    }


}


#Include, %A_LineFile%\..\VSliderGUI.ahk