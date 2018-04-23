import Tkinter as tk
import ttk
import json

def search(event):
    en.delete(0,tk.END)
    en.insert(0,rs.get(ds[cb.get()],'-'))
def rate(event):
    rs[ds[cb.get()]]=float(en.get())
def save(event):
    fd=open("ratings2.json","w")
    json.dump([{"userId":0,"movieId":k,"rating":rs[k]} for k in rs],fd)

root=tk.Tk()
cb=ttk.Combobox(root,width=64)
en=tk.Entry(root,width=16)
bt=tk.Button(root,text="save")
r_fd=open("ratings1.json")
m_fd=open("movies.json")
ds,values={},[]
rs=dict((e["movieId"],e["rating"]) for e in json.load(r_fd))
for e in json.load(m_fd):
    values.append(e["title"])
    ds[e["title"]]=e["movieId"]
cb["values"]=values
cb.bind("<<ComboboxSelected>>",search)
en.bind("<Return>",rate)
en.bind("<LostFocus>",rate)
bt.bind("<Button-1>",save)
cb.pack()
en.pack()
bt.pack()
root.mainloop()
