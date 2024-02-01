defmodule GoBillManagerWeb.ProductController do
  @moduledoc """
    Exposes an API interface to create, show and list product data
  """
  use GoBillManagerWeb, :controller

  alias GoBillManager.Commands.ProductCreate
  alias GoBillManager.Repositories.ProductRepository

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, params) do
    with {:ok, product} <- ProductCreate.run(params) do
      render(conn, "create.json", %{product: product})
    else
      {:error, %Ecto.Changeset{}} ->
        ErrorResponses.bad_request(conn, "invalid_params")

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params),
    do:
      render(conn, "index.json", %{
        products: ProductRepository.list_products()
      })

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, product_id} <- EctoUtils.validate_uuid(id),
         {:ok, product} <- ProductRepository.find(product_id) do
      render(conn, "simplified_product.json", %{product: product})
    else
      {:error, :invalid_uuid} ->
        ErrorResponses.bad_request(conn, "invalid_product_id")

      {:error, :product_not_found} ->
        ErrorResponses.not_found(conn, "product_not_found")
    end
  end
end
