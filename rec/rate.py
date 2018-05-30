import Tkinter as tk
import ttk
import json
import time

def search(event):
    en.delete(0,tk.END)
    en.insert(0,rs.get(ds[cb.get()],'-'))
def rate(event):
    rs[ds[cb.get()]]=float(en.get())
def save(event):
    with open("ratings1.json","w") as fd:
        json.dump([{"userId":0,"movieId":k,"rating":rs[k]} for k in rs],fd)
    la.config(text=time.strftime("%H:%M:%S",time.localtime())+": saved")

root=tk.Tk()
cb=ttk.Combobox(root,width=64)
en=tk.Entry(root,width=8)
bt=tk.Button(root,text="save")
la=tk.Label(width=32)
ds,values={},[]
with open("ratings1.json") as r_fd:
    rs=dict((e["movieId"],e["rating"]) for e in json.load(r_fd))
with open("movies.json") as m_fd:
    for e in json.load(m_fd):
        i=e["title"].rfind("(")
        values.append((e["title"][i+1:i+5] if i>0 else 0,e["title"]))
        ds[e["title"]]=e["movieId"]
cb["values"]=map(lambda x: x[1],sorted(values))

cb.bind("<<ComboboxSelected>>",search)
en.bind("<Return>",rate)
en.bind("<FocusOut>",rate)
bt.bind("<Button-1>",save)
cb.grid(row=0,column=0)
en.grid(row=0,column=1,sticky=tk.N+tk.E+tk.S+tk.W)
bt.grid(row=1,column=0,columnspan=2,sticky=tk.E+tk.W)
la.grid(row=2,column=0,columnspan=2,sticky=tk.E+tk.W)
root.mainloop()
