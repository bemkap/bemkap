function v = pot(a, z, e)
  z = list(z, a*z/norm(a*z, "inf"))
  while norm(z(1)-z(2), "inf") >= e do
    z(1) = z(2)
    w = a*z(1)
    z(2) = w/norm(w, "inf")
  end
  v = list(z(2), w(1)/z(1)(1))
endfunction