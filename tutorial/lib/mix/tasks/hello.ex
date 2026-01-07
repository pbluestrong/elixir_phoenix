defmodule Mix.Tasks.Hello do
  use Mix.Task

  @shortdoc "Calls the Hello.say/0 function."
  def run(_) do
    Mix.Task.run("app.start")

    Tutorial.hello()
  end
end
