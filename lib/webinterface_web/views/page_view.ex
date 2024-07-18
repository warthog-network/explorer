defmodule WebinterfaceWeb.PageView do
  use WebinterfaceWeb, :view

  def link_txhash(conn, txhash) do
    link(txhash, to: Routes.page_path(conn, :transaction, txhash))
  end

  def link_block(conn, height, label \\ nil) do
    label = if label == nil, do: height, else: label
    link(label, to: Routes.page_path(conn, :block, height))
  end

  def link_address(conn, address) do
    label = String.slice(address, 0..3)<>"..."<>String.slice(address, -4..-1)
    link(label, to: Routes.page_path(conn, :lookup, address: address))
  end
  def link_account(conn, address, from, label) do
    link(label, to: Routes.page_path(conn, :lookup, address: address, from: from))
  end
end
