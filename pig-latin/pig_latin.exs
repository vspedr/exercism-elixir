defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map( &(to_pig_latin(&1)) )
    |> Enum.join(" ")
  end

  defp to_pig_latin(word) do
    if starts_with_vowel?(word) do
      word <> "ay"
    else
      word
      |> split()
      # |> IO.inspect
      |> Tuple.to_list()
      # |> IO.inspect
      |> merge()
      # |> IO.inspect
    end
  end

  defp split(word) do
    first_vowel_index = Enum.find_index(String.graphemes(word), &(is_vowel?(&1)))

    cond do
      is_qu?(word, first_vowel_index) ->
        String.split_at(word, first_vowel_index + 1)
      true ->
        String.split_at(word, first_vowel_index)
    end

  end

  defp merge(parts) do
    Enum.at(parts, 1) <> Enum.at(parts, 0) <> "ay"
  end

  defp is_vowel?(char) do
    Enum.member?(String.graphemes("aeiou"), char)
  end

  defp starts_with_vowel?(word) do
    is_vowel?(String.first(word))
  end

  defp is_qu?(word, first_vowel_index) do
    String.at(word, first_vowel_index) == "u" and String.at(word, first_vowel_index - 1) == "q"
  end

  # defp is_xy_vowel?(word) do
  #   Enum.member?(String.graphemes("xy"), char) and not is_vowel(next_char)
  # end
end
