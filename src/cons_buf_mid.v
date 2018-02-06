Definition cons_buf_mid (str: list Z) (cb: list Z) (n: Z) :=
 if (zle_le 0 n (Zlength str - 1))
 then if (zle (n + 1 + Zlength cb) CB_MAX_CHARS)
      then cb ++ firstn (Z.to_nat (n + 1)) str
      else skipn (Z.to_nat (n + 1 + Zlength cb - CB_MAX_CHARS))
                 (cb ++ firstn (Z.to_nat (n + 1)) str)
 else if (zle (Zlength str + Zlength cb) CB_MAX_DW)
      then cb ++ str
      else skipn (Z.to_nat (Zlength str + Zlength cb - CB_MAX_CHARS))
                 (cb ++ str).
