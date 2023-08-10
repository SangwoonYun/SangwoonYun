### If you're using Ubuntu and the Korean/English key doesn't work

#### Check key code
```bash
xev
```
```
KeyPress event, serial 37, synthetic NO, window 0x4600001,
    root 0x76f, subw 0x0, time 152899299, (157,-17), root:(1692,954),
    state 0x10, keycode 108 (keysym 0xff31, Alt_R), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

KeyRelease event, serial 37, synthetic NO, window 0x4600001,
    root 0x76f, subw 0x0, time 152899441, (157,-17), root:(1692,954),
    state 0x18, keycode 108 (keysym 0xff31, Alt_R), same_screen YES,
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False
```

#### Map key
```bash
vi ~/.Xmodmap
```
```
keycode 108 = Hangul
keycode 105 = Hangul_Hanja
```

#### Modify keymap
```bash
xmodmap ~/.Xmodmap
```
