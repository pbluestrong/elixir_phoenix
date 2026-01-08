defmodule Exercises.Ex2.Validation do
  @email_re ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

  def validate_email(str) when is_binary(str) do
    if Regex.match?(@email_re, str), do: {:ok, str}, else: {:error, :invalid_email}
  end

  def validate_email(_), do: {:error, :invalid_email}

  def validate_age(age) when is_integer(age) do
    cond do
      age < 18 -> {:error, :underage}
      age >= 150 -> {:error, :invalid_age}
      true -> {:ok, age}
    end
  end

  def validate_age(_), do: {:error, :invalid_age}

  def validate_password(password) when is_binary(password) do
    cond do
      String.length(password) < 8 -> {:error, :too_short}
      String.length(password) > 16 -> {:error, :too_long}
      not Regex.match?(~r/\d/, password) -> {:error, :missing_digit}
      not Regex.match?(~r/[a-z]/, password) -> {:error, :missing_lowercase}
      not Regex.match?(~r/[A-Z]/, password) -> {:error, :missing_uppercase}
      not Regex.match?(~r/[^a-zA-Z0-9\s]/, password) -> {:error, :missing_special}
      true -> {:ok, password}
    end
  end

  def validate_password(_), do: {:error, :weak_password}
end
