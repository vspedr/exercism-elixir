defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons = rna
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.map( &(to_string(&1)))

    proteins = Enum.map(codons, &ProteinTranslation.of_codon/1)

    error = Enum.find(proteins, fn({key, value}) -> key == :error end )

    if (error) do
      {:error, "invalid RNA"}
    else
      proteins
      |> Enum.reduce_while([], fn({key, value}, acc) -> 
        if value == "STOP" do
          {:halt, acc}
        else
          {:cont, acc ++ [ value ]}
        end
      end)
      |> (fn(prots) -> {:ok, prots} end).()
    end

  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    dictionary = %{
      "Cysteine" => ["UGU", "UGC"],
      "Leucine" => ["UUA", "UUG"],
      "Methionine" => ["AUG"],
      "Phenylalanine" => ["UUU", "UUC"],
      "Serine" => ["UCU", "UCC", "UCA", "UCG"],
      "Tryptophan" => ["UGG"],
      "Tyrosine" => ["UAU", "UAC"],
      "STOP" => ["UAA", "UAG", "UGA"]
    }

    protein = dictionary
    |> Enum.find( fn({key, value}) -> codon in value end )

    if protein do
      {:ok, elem(protein, 0)}
    else
      {:error, "invalid codon"}
    end
  end
end
