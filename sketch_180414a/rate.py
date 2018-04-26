import Tkinter as tk
import ttk
import json

def search(event):
    en.delete(0,tk.END)
    en.insert(0,rs.get(ds[cb.get()],'-'))
def rate(event):
    rs[ds[cb.get()]]=float(en.get())
def save(event):
    fd=open("ratings1.json","w")
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
    i=e["title"].rfind("(")
    values.append((e["title"][i+1:i+5] if i>0 else 0,e["title"]))
    ds[e["title"]]=e["movieId"]
values=sorted(values)
cb["values"]=map(lambda x: x[1],values)

cb.bind("<<ComboboxSelected>>",search)
en.bind("<Return>",rate)
en.bind("<FocusOut>",rate)
bt.bind("<Button-1>",save)
cb.pack(side=tk.LEFT)
en.pack(side=tk.LEFT)
bt.pack(side=tk.LEFT)
root.mainloop()
