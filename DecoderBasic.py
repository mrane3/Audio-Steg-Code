import sys
from tkFileDialog   import askopenfilename  
import matlab.engine

v = sys.version

if "2.7" in v:
    from Tkinter import * 
    import tkFileDialog
elif "3.3" in v or "3.4" in v:
    from tkinter import *
    import tkinter.tkFileDialog

root=Tk()
root.wm_title("Decoder")
text = Text(root) 
text.grid() 

def callback():
    name = askopenfilename() 
    return name

def decode():
    global text
    eng = matlab.engine.start_matlab()
    nameoffile=callback()
    print nameoffile
    eng.addpath('/Users/milaprane/Documents/Milap/Fall 2016/7100-Fall 2016/Audio Steg Code/Matlab')
    message = eng.time_domain_decode(nameoffile)
    print message
    t=text.insert(INSERT,message)

button= Button(root,text="Decode Audio", command=decode)
button.grid()

root.mainloop()