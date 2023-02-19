' TFT Men test
' OPTION SYSTEM SPI CLK, MOSI,MISO
' OPTION SYSTEM SPI GP18, GP19, GP16
' OPTION SDCARD CS GP22
' OPTION LCDPANEL ILI9341, Or, DC, RESET,CS
' git here I come
Option explicit
'taas mennään 
Dim float temp, humidity
Bitbang humid 31 , temp, humidity, 1
Print "The temperature is " temp " and humidity is " humidity
 '

Const menu_levels = 3
Const KEY1 = 22  'GP17
Const KEY2 = 32  'GP27
Const KEY3 = 34  'GP28

Dim integer is_done = 0
Dim integer menu_xpos(2) = (5, 110, 215)
Dim integer menu_ypos(2) = (200,200,200)
Dim string  menu_text(2) = ("Open","Close","Exit")

Dim menu_label(menu_levels) As string = ("Main","Outdoor","Indoor","Peer")
Dim menu_key As integer
Dim key_pressed As integer = 0
Dim key_released As integer = 0


Sub play_ready()
  is_done = 1
End Sub

Sub wait_ready()
  Do While is_done = 0
  Loop
  is_done = 0
End Sub

Sub draw_menu(indx As integer)
    RBox menu_xpos(indx),menu_ypos(indx),100,40,6,RGB(BLUE),RGB(WHITE)
    Text menu_xpos(indx)+5, menu_ypos(indx)+12, menu_text(indx), "LMN",2,1,RGB(BLACK), RGB(WHITE)

End Sub


Sub key1_int()
    Print "key 1"
End Sub

SetPin GP10,DOUT
Pin(GP10) = 1

'SetPin KEY1, INTL,key1_int,PULLUP

SetPin KEY1, DIN, PULLUP
SetPin KEY2, DIN, PULLUP
SetPin KEY3, DIN, PULLUP

'Play wav "big-ben.wav"

Sub tick_10ms()
    Static last_key As integer = 0
    Static key_state As integer  = 0
    Static new_key As integer

    'Print key_state

    new_key = 0
    If Pin(KEY1) = 0 Then
        new_key = 1
    ElseIf Pin(KEY2) = 0 Then
        new_key = 2
    ElseIf Pin(KEY3) = 0 Then
        new_key = 3
    EndIf

    Select Case key_state
        Case 0
            If new_key > 0 Then
                key_pressed = 1
                last_key = new_key
                key_state = 1
            EndIf
        Case 1
            If new_key > 0 Then
                key_pressed = key_pressed + 1
                'last_key = menu_key
                If key_pressed > 10 Then
                    key_state = 2
                EndIf
            EndIf
        Case 2
            If new_key = 0 Then
                key_released = 0
                key_state = 3
            EndIf
        Case 3
            If new_key = 0 Then
                key_released = key_released + 1
                'last_key = menu_key
                If key_released > 5 Then
                    key_state = 0
                    menu_key = last_key
                    last_key = 0
                EndIf
            EndIf

    End Select
    If menu_key = 0 Then
    EndIf
End Sub


SetTick 10, tick_10ms,1


Do While 0
    If menu_key > 0 Then
        Print "Menu " menu_key
        menu_key = 0
    EndIf
Loop


Colour RGB(GREEN),RGB(BLUE)
CLS

Sub Menu(m_indx As integer)
    Local i As integer
    Text 5, 185, menu_label(m_indx),"LMN",2,1,RGB(WHITE)
    For i = 0 To 2
        draw_menu(i)
    Next i
End Sub

Menu(1)

'RBox 5,200,110,40,6,RGB(BLUE),RGB(WHITE)

Text 10,20, "Lampotila", "LMN", 2, 1, RGB(YELLOW)
Text 150,20, "Kosteus", "LMN", 2, 1, RGB(YELLOW)
Text 10,70, Str$(temp), "LMN", 6, 1, RGB(YELLOW)
Text 150,70, Str$(humidity), "LMN", 6, 1, RGB(YELLOW)
'Text 10,90, "Tekstia", "LMN", 3, 1, RGB(YELLOW),RGB(BLACK)

Do
    Select Case  menu_key

        Case 1
            menu_text(0) ="menu 1"

        Case 2
            menu_text(1) ="menu 2"

        Case 3
            menu_text(2) ="menu 3"

    End Select
    If menu_key > 0 Then
        Menu(1)
        menu_key = 0
    EndIf
Loop


'Dim menu_key As float
'KeyPad menu_key, MenuKeyInt,GP8,GP8,GP8,GP8,GP28,GP27,GP17

'Sub MenuKeyInt
'    Print "menu key" menu_key
'End Sub

Do
    Pin(GP10) = 1
    Pause (200)
    'Pin(GP10) = 0
    'Pause (200)
Loop




'is_done =0
'Play wav "big-ben.wav", play_ready
'wait_ready()

'Play wav "count_0_12.wav", play_ready
'wait_ready()

'For t = 100 To 1000
'  Play tone t,t
'  Pause 10
'Next t
'For t = 1000 To 50 Step -1
'  Play tone t,t
'  Pause 10
'Next t
'Play stop
End���������������������������������������������������������������������������������������������������������������������������
