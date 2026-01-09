defmodule OtpExercisesTest do
  use ExUnit.Case
  doctest OtpExercises

  test "greets the world" do
    assert OtpExercises.hello() == :world
  end
end
