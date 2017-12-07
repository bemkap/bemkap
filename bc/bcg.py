import bcm
import Tkinter as tk

class gui(tk.Frame):
    def __init__(self,master=None):
        tk.Frame.__init__(self,master)
        self.db=bcm.bc()
        self.grid()
        self.createWidgets()
    def createWidgets(self):
        self.quitbutton=tk.Button(self,text='salir',command=self.quit)
        self.platlist=tk.Listbox(self)
        self.ingrlist=tk.Listbox(self)
        self.catelist=tk.Listbox(self)
        self.preplist=tk.Listbox(self)
        self.bitalist=tk.Listbox(self)
        for r in self.db.select("plat"):self.platlist.insert(tk.END,r[0])
        
        self.quitbutton.grid()
        self.platlist.grid()
        self.ingrlist.grid()
        self.catelist.grid()        
        self.preplist.grid()
        self.bitalist.grid()

app=gui()
app.master.title('bc')
app.mainloop()
