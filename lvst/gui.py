import Tkinter as tk
import json
import threading
from ven import db

class gui:
    def __init__(self):
        self.root=tk.Tk()
        self.lab=[tk.Label(self.root),tk.Label(self.root)]
        self.lst=[tk.Listbox(self.root),tk.Listbox(self.root)]
        self.scr=[tk.Scrollbar(self.root),tk.Scrollbar(self.root)]
        self.stt=tk.Listbox(self.root)
        self.n=0
        self.db=db(self)
        self.fill()
        for i in xrange(2):
            self.lst[i].config(yscrollcommand=self.scr[i].set)
            self.lab[i].grid(row=0,column=i*2)
            self.lst[i].grid(row=1,column=i*2)
            self.scr[i].config(command=self.lst[i].yview)
            self.scr[i].grid(row=1,column=1+i*2,sticky=tk.N+tk.S)
        self.stt.grid(row=2,column=0,columnspan=4,sticky=tk.W+tk.E)
        self.lst[1].bind("<Double-Button-1>",self.begin_dl)
        self.root.protocol("WM_DELETE_WINDOW",self.close)
        self.root.mainloop()
    def fill(self):
        for l in self.lst: l.delete(0,tk.END)
        for i in sorted(self.db.downloaded()): self.lst[0].insert(tk.END,i)
        for i in sorted(self.db.left()): self.lst[1].insert(tk.END,i)
        for i,l in enumerate(["downloaded(%d)","left(%d)"]):
            self.lab[i].config(text=l%self.lst[i].size())
    def act(self,k,n):
        s=self.stt.get(n)
        self.stt.itemconfig(n,text="%s %s"%(s,k))
        # self.stt.config(text="%s %s"%(self.lst[1].get(tk.ACTIVE),k))
    def finish(self):
        self.db.set(self.lst[1].get(tk.ACTIVE))
        self.fill()
    def close(self):
        self.db.close()
        self.root.destroy()
    def begin_dl(self,event):
        self.stt.insert(tk.END,"%s"%self.lst[1].get(tk.ACTIVE))
        t=threading.Thread(target=self.db.download,args=(self.lst[1].get(tk.ACTIVE),self.n))
        self.n+=1
        t.start()

gui()
