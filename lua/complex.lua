function cadd(a, b)
  return {a[1] + b[1], a[2] + b[2]}
end

function csub(a,b)
  return {a[1] - b[1], a[2] - b[2]}
end

function cmul(a, b)
  return {a[1] * b[1] - a[2] * b[2], a[1] * b[2] + a[1] * b[2]}
end

function cconj(a)
  return {a[1],-1 * a[2]}
end

function cdiv(a, b)
  complextop = cmul(a,cconj(b))
  complexbot = cmul(b,cconj(b))
  return {complextop[1] / complexbot[1], complextop[2] / complexbot[1]}
end
