Class VSliderGUI {


    static bcolor := "090909" ;background color
    static pcolor := "E9E9E9" ;progressbar color
    static tcolor := "666666" ;text color
    
    
    __New(guiName, width, height, fsize, iconOffsetx, iconOffsety, bradius, y){
        this.guiName := guiName
        this.width := width
        this.height := height
        this.fsize := fsize
        this.iconOffset := {"x": iconOffsetx, "y": iconOffsety}
        this.bradius := bradius
        this.y := y
        this._registerGui()
        this._addControls()
        this._finaliseGui()
    }


    show(icon, vol){
        ;code for displaying gui
    }


    hide(){
        ;code to hide the gui
    }


    _registerGui(){
        Gui, % this.guiName ":New" ; create GUI with needed options
                , %  "+Hwndhwnd +LastFound +ToolWindow"
                    ."+AlwaysOnTop -Caption -Disabled"
                , this.guiName
        this.hwnd := hwnd
        DllCall("SetClassLong" ; Drop Shadow
                , "UInt", this.hwnd
                , "Int", -26
                , "Int", DllCall("GetClassLong"
                        , "UInt", this.hwnd
                        , "Int", -26) | 0x20000)
        Gui, % this.hwnd ":Color" ; setting background Color
                , this.tcolor, this.tcolor
    }


    _addControls(){
        Gui, % this.hwnd ":Add"
                , Progress
                , % "vVolSlider"
                    . " x" . -1
                    . " y" . -1
                    . " w" . this.width
                    . " h" . this.height
                    . " c" . this.pcolor
                    . " Background" this.bcolor
                , 50
        Gui, % this.hwnd ":Font"
                , % "s" . this.tsize . " c" . this.tcolor
                , Segoe MDL2 Assets
        Gui, % this.hwnd ":Add"
                , Text
                , % "BackgroundTrans" 
                    . " vVolIcon"
                    . " x" . this.iconOffset.x
                    . " y" . this.iconOffset.y
                , % ""
        Gui, % this.hwnd ":Margin", 0, 0

        this.vol := {}
        this.vol.slider := VolSlider
        this.vol.icon := VolIcon
    }


    _finaliseGui(){
        DetectHiddenWindows, On
        Gui, % this.hwnd ":Show", Hide ; Pre-render GUI
        WinSet, Transparent, 0, % "ahk_id " . this.hwnd ; Apply 0% transparency
        WinGetPos, , , width, height, % "ahk_id " . this.hwnd ; Get GUI info
        x := (A_ScreenWidth / 2) - (width / 2) ; Calculate true screen center
        Gui, % this.hwnd ":Show"
                , % "x" x 
                    . " y" . this.y
                    . " NA"
        WinSet, Region, % Format("0-0 w{1:d} h{2:d} r{3:d}-{3:d}"
                            , width
                            , height
                            , this.bradius) ; Apply rounded corners
                , % "ahk_id " . this.hwnd
    }


    __Delete(){
        Gui, % this.hwnd . ":Destroy"
    }


}