s=:    7 12 17 22  7 12 17 22  7 12 17 22  7 12 17 22
s=: s, 5  9 14 20  5  9 14 20  5  9 14 20  5  9 14 20
s=: s, 4 11 16 23  4 11 16 23  4 11 16 23  4 11 16 23
s=: s, 6 10 15 21  6 10 15 21  6 10 15 21  6 10 15 21

K=:   x:16bd76aa478 16be8c7b756 16b242070db 16bc1bdceee
K=: K,x:16bf57c0faf 16b4787c62a 16ba8304613 16bfd469501
K=: K,x:16b698098d8 16b8b44f7af 16bffff5bb1 16b895cd7be
K=: K,x:16b6b901122 16bfd987193 16ba679438e 16b49b40821
K=: K,x:16bf61e2562 16bc040b340 16b265e5a51 16be9b6c7aa
K=: K,x:16bd62f105d 16b02441453 16bd8a1e681 16be7d3fbc8
K=: K,x:16b21e1cde6 16bc33707d6 16bf4d50d87 16b455a14ed
K=: K,x:16ba9e3e905 16bfcefa3f8 16b676f02d9 16b8d2a4c8a
K=: K,x:16bfffa3942 16b8771f681 16b6d9d6122 16bfde5380c
K=: K,x:16ba4beea44 16b4bdecfa9 16bf6bb4b60 16bbebfbc70
K=: K,x:16b289b7ec6 16beaa127fa 16bd4ef3085 16b04881d05
K=: K,x:16bd9d4d039 16be6db99e5 16b1fa27cf8 16bc4ac5665
K=: K,x:16bf4292244 16b432aff97 16bab9423a7 16bfc93a039
K=: K,x:16b655b59c3 16b8f0ccc92 16bffeff47d 16b85845dd1
K=: K,x:16b6fa87e4f 16bfe2ce6e0 16ba3014314 16b4e0811a1
K=: K,x:16bf7537e82 16bbd3af235 16b2ad7d2bb 16beb86d391

a0=: x:16b67452301
b0=: x:16befcdab89
c0=: x:16b98badcfe
d0=: x:16b10325476

and=: 17 b.
or=: 23 b.
xor=: 22 b.
not=: (30 b.)~
lsh=: 33 b.
lrotate=: lsh~ or (lsh~ -&32)

md5=: 3 : 0
l=. #: #y
y=. 1 ,~ ,(8#2) #: a. i. y
z=. 512&+^:(<&0)@:(448 - 512 | #) y
y=. y,z#0
y=. y,l
y=. (,:~512) (16 32$(512&{.));.3 y
'A B C D'=. a0,b0,c0,d0
y=. #."1 x: y
for_i. i.16 do.
 F=. (B and C) or ((not B) and D)
 g=. i
end.
for_i. 16+i.16 do.
 F=. (D and B) or ((not D) and C)
 g=. 16|>:5*i
 dTemp=. D
 D=. C
 C=. B
 B=. B+(A+F+(i{K)+(g{y)) lrotate i{s
 A=. dTemp
end.
for_i. 32+i.16 do.
 F=. B xor C xor D
 g=. 16|5+3*i
end.
for_i. 48+i.16 do.
 F=. C xor (B or (not D))
 g=. 16|7*i
end.
)