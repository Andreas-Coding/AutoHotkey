#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
test := new VSliderGUI("nSlider"
                        , 322
                        , 98
                        , 48
                        , 24
                        , 16
                        , 48
                        , "Center"
                        , 224
                        , 1500)
tester(test)
return

tester(test){
    static counter := 0
    static rv := 50
    counter++
    if(counter > 25)
        return
    
    Random, rt, -1000, -50
    shit := Func("tester").Bind(test)
    SetTimer, % shit, % rt
    rv += rand()
    test.update(rv, _getIcon(rv))
}

rand(){
    Random, r, -10, 10
    return, r
}

_getIcon(vol){
    if(vol < 1)
        return, ""
            
    if(vol < 33)
        return, ""
            
    if(vol < 66)
        return, ""

    return, ""
}


#Include, assets\VSliderGui.ahk