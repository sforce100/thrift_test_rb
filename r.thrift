# Define a struct, an exception and a 'quick service - QService'
# - To learn more about Thrift's datatypes, head to:
# - http://developers.facebook.com/thrift/

 struct Lookup {
  1:string bucket,
  2:string key
 }

 exception InvalidKey {
  1: string error
 }

service QService {

  /**
   * A method definition looks like C code. It has a return type, arguments,
   * and optionally a list of exceptions that it may throw. Note that argument
   * lists and exception lists are specified using the exact same syntax as
   * field lists in struct or exception definitions.
   */

   i32 exponent(1:i32 base, 2:i32 exp),
   string get_key(1:Lookup l) throws (1:InvalidKey e),
   async void run_task()

}
