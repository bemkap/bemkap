import Tkinter as tk
import json
import threading
from db import db

class gui:
    def __init__(self):
        self.root=tk.Tk()
        self.lab=tk.Label(self.root)
        self.lst=tk.Listbox(self.root)
        self.scr=tk.Scrollbar(self.root)
        self.stt=tk.Listbox(self.root)
        self.cnt=tk.Label(self.root,height=16,bg="white",justify=tk.LEFT)
        self.rec=tk.Button(self.root,text="rec")
        self.dow=tk.Button(self.root,text="dl")
        self.n=0
        self.db=db(self)
        self.fill()
        self.lock=threading.Lock()
        self.lst.config(yscrollcommand=self.scr.set)
        self.lab.grid(row=0,column=0)
        self.lst.grid(row=1,column=0)
        self.scr.config(command=self.lst.yview)
        self.scr.grid(row=1,column=1,rowspan=2,sticky=tk.N+tk.S)
        self.stt.grid(row=1,column=2,rowspan=2)
        self.rec.grid(row=1,column=3)
        self.dow.grid(row=2,column=3)
        self.lst.bind("<Double-Button-1>",self.begin_dl)
        self.lst.bind("<Button-1>",self.show_cnt)
        self.cnt.grid(row=3,column=0,columnspan=4,sticky=tk.E+tk.W)
        self.root.protocol("WM_DELETE_WINDOW",self.close)
        self.root.mainloop()
    def fill(self):
        self.lst.delete(0,tk.END)
        self.lst.insert(tk.END,*sorted(self.db.left()))
        self.lab.config(text="left(%d)"%self.lst.size())
    def act(self,k,n):
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
        self.root.destroy()
    def begin_dl(self,event):
        self.stt.insert(tk.END,self.lst.get(tk.ACTIVE))
        threading.Thread(target=self.db.download,args=(self.lst.get(tk.ACTIVE),self.n)).start()
        self.n+=1
    def show_cnt(self,event):
        self.cnt.config(text=self.db.content(self.lst.get(tk.ACTIVE)))

gui()
