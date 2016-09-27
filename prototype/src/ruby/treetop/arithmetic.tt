grammar Arithmetic
  rule additive
    multitive ( '+' multitive )*
  end

  rule multitive
    primary ( [*/%] primary )*
  end

  rule primary
    '(' additive ')' / number
  end

  rule number
    '-'? [1-9] [0-9]*
  end
end
