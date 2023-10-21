# nil.cr
def my_method(**args)
  args.to_h.transform_keys(&.to_s.upcase)
end

puts my_var = my_method(a: 1, b: 2, c: 3) # Returns a Hash(String, Int32) {"A"=>1, "B"=>2}

puts my_var = my_method() # Returns an empty Hash(String, NoReturn) {}

# my_var is always a Hash but it may not have any values
