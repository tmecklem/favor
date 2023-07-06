defmodule Favor do
  @moduledoc """
  This is the entrypoint for making requests to Favro via the Favor library.
  """

  use Tesla

  def client(username, api_token, base_url) do
    base_url = process_base(base_url)

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
      {Tesla.Middleware.BasicAuth, %{username: username, password: api_token}},
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middleware)
  end

  defp process_base(base_url) do
    if Regex.match?(~r/^https?:\/\//i, base_url) do
      base_url
    else
      "https://" <> base_url
    end
  end
end
