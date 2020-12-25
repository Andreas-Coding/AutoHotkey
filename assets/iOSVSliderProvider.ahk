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


    initialize(){
        this.slider := {}
        this.slider.large := new VSliderGUI("large", 322, 98, 48, 24, 16, 48, "Center")
        this.slider.small := new VSliderGUI("small", 192, 50, 24, 16, 8, 24, 80)
    }


    _getVol(device := "MASTER"){
        SoundGet, vol, % device, % "VOL"
        return, Round(vol)
    }


    _getIcon(device := "MASTER"){
        SoundGet, SysMuteState, % device, % "Mute"
        if(SysMuteState != "Off")
            return, ""
        
        vol := this._getVol(device)

        if(vol < 1)
            return, ""
            
        if(vol < 33)
            return, ""
            
        if(vol < 66)
            return, ""

        return, ""
    }


    _getVariant(){
        atts := this._winGetAttributes("A")
        if((atts.class == "Windows.UI.Core.CoreWindow")
                || (atts.class == "WorkerW"))
            return, False

        
    }


    _winGetAttributes(title){
        r := {}

        WinGetTitle, t, % title
        r.title := t

        WinGetClass, c, % title
        r.class := c

        for _, element in ["ID", "PID", "ProcessName", "ProcessPath"] {
            WinGet, out, % element, % title
            r[element] := out
        }

        return, r
    }


}


#Include, %A_LineFile%\..\VSliderGUI.ahk