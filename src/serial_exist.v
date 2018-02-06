(* Specification *)
Function set_serial_exist_spec (v: Z) 
 (serial: Abs): option Abs :=
 if zeq 0 v then
   Some (serial {serial_exist: false})
 else if zlt_le 0 v Int.max_unsigned then
   Some (serial {serial_exist: true})
 else None
<@ \columnbreak @>
// Implementation
void set_serial_exist(unsigned int ex)
{
 if (ex > 0) {
  serial_exist = true;
 } else {
  serial_exist = false;
 }
}
