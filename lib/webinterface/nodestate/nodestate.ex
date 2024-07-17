defmodule Nodestate do
  @host "localhost"
  @port "3000"
  defp socket() do
    @host<>":"<> @port 
  end
  defp request(url) do
    with {:ok,res} <- HTTPoison.get(url),
         {:ok,parsed} <- Jason.decode(res.body) do
      Map.fetch(parsed,"data")
    else
      error -> error
    end
  end
  def transaction(txhash) do
    socket()<>"/transaction/lookup/#{txhash}"
    |>request()
  end
  def head() do
    socket()<>"/chain/head"
    |>request()
  end
  def banned() do
    socket() <>"/peers/banned"
    |>request()
  end
  def connected() do
    socket() <>"/peers/connected"
    |>request()
  end
  def balance(address) when is_binary(address) do
    socket() <>"/account/#{address}/balance"
    |> request()
  end
  def block(n) when is_integer(n) do
    socket() <>"/chain/block/#{n}"
    |> request()
  end
  def history(address,beforeId) when is_binary(address) and is_integer(beforeId) do
    socket() <>"/account/#{address}/history/#{beforeId}"
    |> request()
  end
end
