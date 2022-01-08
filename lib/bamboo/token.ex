defmodule Bamboo.Token do
  @moduledoc """
    Implement token module
  """
  @signing_salt System.get_env("SIGNING_SALT") || "secret"

  # token for 12 hours
  @token_age_secs 43200

  @doc """
  Create token for given data
  """
  def sign(data) do
    signing_salt = System.get_env("SIGNING_SALT")
    Phoenix.Token.sign(BambooWeb.Endpoint, signing_salt, data)
  end

   @doc """
  Verify given token by:
  - Verify token signature
  - Verify expiration time
  """
  def verify(token) do
    signing_salt = System.get_env("SIGNING_SALT")
    case Phoenix.Token.verify(BambooWeb.Endpoint, signing_salt, token, max_age: @token_age_secs) do
      {:ok, data} -> {:ok, data}
      _error -> {:error, :unauthorized}
    end
  end
end
