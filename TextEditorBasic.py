            
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
root=Tk("Text Editor")
root.wm_title("Encoder")
text=Text(root) 
text.grid() 

def saveas():
    global text
    t = text.get("1.0", "end-1c")
    savelocation=tkFileDialog.asksaveasfilename()
    file1=open(savelocation, "w+")
    file1.write(t)
    file1.close()
button=Button(root, text="Save", command=saveas) 
button.grid()

def callback():
    name = askopenfilename() 
    return name

def encode():
    global text
    eng = matlab.engine.start_matlab()
    t = text.get("1.0", "end-1c")
    print t
    nameoffile=callback()
    print nameoffile
    eng.addpath('/Users/milaprane/Documents/Milap/Fall 2016/7100-Fall 2016/Audio Steg Code/Matlab')
    eng.time_domain_encode(nameoffile, t,nargout=0)

button2= Button(root,text="Encode Audio", command=encode)
button2.grid()

def FontTimes():
    global text
    text.config(font="Times")

def FontCourier():
    global text
    text.config(font="Courier")

font=Menubutton(root, text="Font") 
font.grid() 
font.menu=Menu(font, tearoff=0) 
font["menu"]=font.menu
Helvetica=IntVar() 
arial=IntVar() 
times=IntVar() 
Courier=IntVar()
font.menu.add_checkbutton(label="Courier", variable= Courier, 

command=FontCourier)
font.menu.add_checkbutton(label="Times", variable= times,
command=FontTimes) 

root.mainloop()


