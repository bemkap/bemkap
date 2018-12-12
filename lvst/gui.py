import Tkinter as tk
import json
import threading
from db import db

class gui(tk.Tk):
    def __init__(self):
        tk.Tk.__init__(self)
        self.lab=tk.Label(self)
        self.lst=tk.Listbox(self,width=32)
        self.sbl=tk.Scrollbar(self,command=self.lst.yview)
        self.stt=tk.Listbox(self,width=32)
        self.cnt=tk.Text(self,height=24)
        self.sbc=tk.Scrollbar(self,command=self.cnt.yview)
        self.rec=tk.Button(self,text="rec",command=self.begin_rec)
        self.dow=tk.Button(self,text="dl",command=self.begin_dl)
        self.n=0
        self.db=db(self)
        self.fill()
        self.lock=threading.Lock()
        self.lst.config(yscrollcommand=self.sbl.set)
        self.cnt.config(yscrollcommand=self.sbc.set)
        self.lab.grid(row=0,column=0,sticky=tk.N+tk.S+tk.E+tk.W)
        self.lst.grid(row=1,column=0,rowspan=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.sbl.grid(row=1,column=0,rowspan=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.stt.grid(row=1,column=1,rowspan=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.rec.grid(row=1,column=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.dow.grid(row=2,column=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.cnt.grid(row=3,column=0,columnspan=3,sticky=tk.N+tk.S+tk.E+tk.W)
        self.sbc.grid(row=3,column=2,sticky=tk.N+tk.S+tk.E+tk.W)
        self.lst.bind("<Button-1>",self.show_cnt)
        self.protocol("WM_DELETE_WINDOW",self.close)
    def fill(self):
        self.lst.delete(0,tk.END)
        self.lst.insert(tk.END,*sorted(self.db.left()))
        self.lab.config(text="left(%d)"%self.lst.size())
    def refresh(self,k,n):
        fn=self.stt.get(tk.ACTIVE).split(" ")[0]
        with self.lock:
            self.stt.delete(n)
            self.stt.insert(n,"%s %s"%(fn,k))
    def finish(self):
        with self.lock:
            self.db.set(self.lst.get(tk.ACTIVE))
            self.fill()
    def close(self):
        self.db.close()
        self.destroy()
    def begin_rec(self):
        p=1
        while len(self.db.left())<20:
            self.db.record(p)
            self.fill()
            p+=1
    def begin_dl(self):
        self.stt.insert(tk.END,self.lst.get(tk.ACTIVE))
        threading.Thread(target=self.db.download,args=(self.lst.get(tk.ACTIVE),self.n)).start()
        self.n+=1
    def show_cnt(self,event):
        self.cnt.delete(1.0,tk.END)
        self.cnt.insert(tk.END,self.db.content(self.lst.get(tk.ACTIVE)))

gui().mainloop()
