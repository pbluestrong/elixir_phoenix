# import
# import Enum
# import Enum, only: [map: 2]

# require: đảm bảo module được compile trước khi dùng macro -> khi cần dùng macro từ module khác
defmodule Learn.Modules.Require.MyMacros do
  defmacro hello(name) do
    quote do
      IO.puts("Hello, #{unquote(name)}!")
    end
  end
end

defmodule Learn.Modules.Require.Test do
  alias Learn.Modules.Require.MyMacros
  require MyMacros
end

# use: muốn inject code của module khác
# ex1:
# defmodule Learn.Modules.Use do
#   defmacro __using__(_opts) do
#     quote do
#       def hello(name), do: "Hi, #{name}"
#     end
#   ends
# end

# defmodule Learn.Modules.Test do
#   use Learn.Modules.Use
# end

#ex2:
defmodule Learn.Modules.Use do
  defmacro __using__(opts) do
    greeting = Keyword.get(opts, :greeting, "Hi")

    quote do
      def hello(name), do: unquote(greeting) <> ", " <> name
    end
  end
end

defmodule Learn.Modules.Test do
  use Learn.Modules.Use, greeting: "Hello"
end
