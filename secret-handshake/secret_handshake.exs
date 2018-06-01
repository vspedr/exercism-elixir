use Bitwise
defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    availableActions = %{
      0b1 => "wink",
      0b10 => "double blink",
      0b100 => "close your eyes",
      0b1000 => "jump" 
    }

    commandList = availableActions
    |> Map.keys()
    |> Enum.filter( fn(bit) when band(code, bit) === bit -> true; _ -> false end)
    |> Enum.map( fn(bit) -> Map.get(availableActions, bit) end )

    cond do
      band(code, 0b10000) === 0b10000 -> Enum.reverse(commandList)
      true -> commandList
    end

  end
end
