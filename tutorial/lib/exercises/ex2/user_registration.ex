defmodule Exercises.Ex2.UserRegistration do
  alias Exercises.Ex2.Validation
  alias Exercises.Ex2.User

  def register_user(attrs) when is_map(attrs) do
    with  {:ok, email} <- Validation.validate_email(Map.get(attrs, :email)),
          {:ok, age} <- Validation.validate_age(Map.get(attrs, :age)),
          {:ok, password} <- Validation.validate_password(Map.get(attrs, :password)) do
        user = %User{id: :rand.uniform(1000), email: email, age: age, hashed_password: hash_pw(password)}
        number = Enum.random(0..1)
        if(number==0) do
          {:ok, user}
        else
          {:error, :server_error}
        end
    end
  end

  def register_user(_), do: {:error, :invalid_input}

  defp hash_pw(password), do: String.reverse(password)
end
