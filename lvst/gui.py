import Tkinter as tk
import json
import ven
from ven import db

class gui:
    def __init__(self):
        self.root=tk.Tk()
        self.lab=[tk.Label(self.root),tk.Label(self.root)]
        self.lst=[tk.Listbox(self.root),tk.Listbox(self.root)]
        self.scr=[tk.Scrollbar(self.root),tk.Scrollbar(self.root)]
        self.stt=tk.Label(self.root,anchor=tk.W)
        self.db=db()
        self.fill()
        for i in [0,1]:
            self.lst[i].config(yscrollcommand=self.scr[i].set)
            self.lab[i].grid(row=0,column=i*2)
            self.lst[i].grid(row=1,column=i*2)
            self.scr[i].config(command=self.lst[i].yview)
            self.scr[i].grid(row=1,column=1+i*2,sticky=tk.N+tk.S)
        self.stt.grid(row=2,column=0,columnspan=4,sticky=tk.W)
        self.lst[1].bind("<Double-Button-1>",self.sel0)
        self.root.mainloop()
    def fill(self):
        self.lab[0].config(text="downloaded({0})".format(self.lst[0].size()))
        self.lst[0].delete(0,tk.END)
        self.lab[1].config(text="lelf({0})".format(self.lst[1].size()))
        self.lst[1].delete(1,tk.END)
        for i in sorted(self.db.downloaded()): self.lst[0].insert(tk.END,i)
        for i in sorted(self.db.left()): self.lst[1].insert(tk.END,i)
    def sel0(self,event):
        self.stt.config(text="downloading {0}...".format(self.lst[1].get(tk.ACTIVE)))
        self.db.download_one(self.lst[1].get(tk.ACTIVE))
        self.stt.config(text=self.stt.cget("text")+"ok")
        self.fill()

G=gui()

