defmodule WebinterfaceWeb.PageController do
  use WebinterfaceWeb, :controller

  def explorer(conn, _params) do
    {:ok, %{"height" => height}} = Nodestate.head()
    {:ok, b} = Nodestate.block(height)
    render(conn, "explorer.html", latest: b)
  end

  def block(conn, %{"height" => height}) do
    {h, ""} = Integer.parse(height)
    {:ok, b} = Nodestate.block(h)
    render(conn, "block.html", block: b)
  end

  def account(conn, %{"address" => address} = params) do
    {from, ""} = Map.get(params, "from", "1000000000000000000") |> Integer.parse()
    before = from + 100
    {:ok, data} = Nodestate.history(address, before)
    render(conn, "account.html", address: address, data: data)
  end

  def transaction(conn, %{"txhash" => txhash}) do
    {:ok, tx} = Nodestate.transaction(txhash)
    render(conn, "transaction.html", tx: tx)
  end

  def head(conn, _params) do
    {:ok, %{"height" => height}} = Nodestate.head()
    head = %{height: height}
    render(conn, "head.html", head: head)
  end

  def balance(conn, %{"address" => address}) do
    {:ok, info} = Nodestate.balance(address)

    case info do
      %{"error" => error} ->
        render(conn, "balance_error.html", error: error, address: address)

      %{"balance" => balance} ->
        render(conn, "account.html", balance: balance, address: address)
    end
  end

  def banned(conn, _params) do
    {:ok, list} = Nodestate.banned()
    render(conn, "banned.html", list: list)
  end

  def connected(conn, _params) do
    {:ok, list} = Nodestate.connected()
    render(conn, "connected.html", list: list)
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
