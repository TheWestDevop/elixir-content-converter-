# FcmDigitalChallenge

**How to Run the Program**

## 
Set up  elixir on your laptop and open your iex terminal by typing this command

```elixir
 iex -S mix 
```

after the iex terminal has opened, kindly proceed to import module ```FcmDigitalChallenge ``` by typing  this command 

```elixir
  iex(0)> alias  FcmDigitalChallenge
```
 after importing the module, then you can run the program by typing the following command

 ```elixir
 iex(1)> file_path = "input.txt"
 iex(2)> FcmDigitalChallenge.format(file_path)
 ```

 **How to Run the Program Test**

 to run the attached test, kindly type the following command into the iex terminal 

 ```elixir
  iex(3)> mix test test/fcm_digital_challenge_test.exs
```
