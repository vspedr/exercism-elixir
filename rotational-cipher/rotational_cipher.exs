defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map( fn(c) ->
        cond do
          (c >= ?A) and (c <= ?Z) -> rem((c + shift - ?A), 26) + ?A
          (c >= ?a) and (c <= ?z) -> rem((c + shift - ?a), 26) + ?a
          true -> c
        end
      end)
    |> to_string()

  end
end
