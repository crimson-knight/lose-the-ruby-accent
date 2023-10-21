require "./spec_helper"

class MyRedisClient < AbstractRedisClientExpected
  property cache : Hash(String, String) = {} of String => String

  def get(key : String) : String
    @cache[key]
  end

  def set(key : String, value : String)
    @cache[key] = value
    key
  end
end

describe MyDemoApp do
  it "sets a key" do
    my_redis_client = MyRedisClient.new
    my_app = MyDemoApp.new(my_redis_client)
    key = my_app.random_key_store

    my_redis_client.cache[key].should be_a(String)
  end

  it "looks up a key" do
    my_redis_client = MyRedisClient.new
    my_app = MyDemoApp.new(my_redis_client)
    my_app.set_an_exact_value("fluffy", "kitty") # 🐈

    my_app.what_was_that?("fluffy").should eq("kitty")
  end
end
