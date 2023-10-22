require "uuid"

# This class serves as a placeholder for a possible redis client and the specific methods we rely on.
#
# Any redis client used must define these methods.
abstract class AbstractRedisClientExpected
  # Get the value for a key.
  abstract def get(key : String) : String

  # Set the value for a key.
  #
  # ```
  # redis_client = MyRedisClient.new
  # redis_client.set("my_key", "my_value") # => "my_value"
  # ```
  abstract def set(key : String, value : String)
end

# This is the class for my demo app! :)
#
# The `MyDemoApp` is the primary entry point for using this library, it requires a redis client that 
# inherits from `AbstractRedisClientExpected` to be passed in at the time of initialization.
#
# ```crystal
# require "./my_demo_app"
# 
# class MyRedisClient < AbstractRedisClientExpected
#   property cache : Hash(String, String) = {} of String => String
#
#   def get(key : String) : String
#     @cache[key]
#   end
#
#   def set(key : String, value : String)
#     @cache[key] = value
#     key
#   end
# end
#
# my_app = MyDemoApp.new(redis_client: MyRedisClient.new)
# my_app.random_key_store # => "some_random_key"
# ```
#
class MyDemoApp
  # This expects a class that represents some kind of redis client.
  #
  # See `AbstractRedisClientExpected` for the required method definitions.
  #
  def initialize(redis_client : AbstractRedisClientExpected)
    @redis_client = redis_client
  end

  # Use this method if you forgot the value that was stored for a key.
  #
  # This won't help if you've forgotten your key 😉
  def what_was_that?(key) : String
    @redis_client.get(key)
  end

  # This will let you set an exact key/value pair.
  def set_an_exact_value(key, value) : String
    @redis_client.set(key, value)
  end

  # This will let you set a random key/value pair.
  #
  # Why not? 🤷‍♂️ It's a demo after all! 😁
  def random_key_store : String
    key = UUID.random.to_s
    value = Random.rand(1000).to_s
    @redis_client.set(key, value)
  end
end
