# nil.rb
def my_method(**args)
  args&.transform_keys { |k| k.to_s.upcase }
end

puts my_var = my_method(a: 1, b: 2, c: 3) # Returns {"A" => 1, "B" => 2, "C" => 3}

puts my_var = my_method # Returns nil

# We can never trust that my_var will be a Hash in the rest of our app 😕
