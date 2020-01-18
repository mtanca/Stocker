defmodule StockScreener.Symbols do
  @moduledoc """
  The Stocksymbol context.
  """

  import Ecto.Query, warn: false
  alias StockScreener.Repo

  alias StockScreener.Symbols.Symbol

  @doc """
  Returns the list of symbols.

  ## Examples

      iex> list_symbols()
      [%symbol{}, ...]

  """
  def list_symbols do
    Repo.all(Symbol)
  end

  @doc """
  Gets a single symbol.

  Raises `Ecto.NoResultsError` if the symbol does not exist.

  ## Examples

      iex> get_symbol!(123)
      %symbol{}

      iex> get_symbol!(456)
      ** (Ecto.NoResultsError)

  """
  def get_symbol!(id), do: Repo.get!(Symbol, id)

  @doc """
  Creates a symbol.

  ## Examples

      iex> create_symbol(%{field: value})
      {:ok, %symbol{}}

      iex> create_symbol(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_symbol(attrs \\ %{}) do
    %Symbol{}
    |> Symbol.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a symbol.

  ## Examples

      iex> update_symbol(symbol, %{field: new_value})
      {:ok, %symbol{}}

      iex> update_symbol(symbol, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_symbol(%Symbol{} = symbol, attrs) do
    symbol
    |> symbol.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a symbol.

  ## Examples

      iex> delete_symbol(symbol)
      {:ok, %symbol{}}

      iex> delete_symbol(symbol)
      {:error, %Ecto.Changeset{}}

  """
  def delete_symbol(%Symbol{} = symbol) do
    Repo.delete(symbol)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking symbol changes.

  ## Examples

      iex> change_symbol(symbol)
      %Ecto.Changeset{source: %symbol{}}

  """
  def change_symbol(%Symbol{} = symbol) do
    symbol.changeset(symbol, %{})
  end
end
