defmodule PubNux.Config do
  @moduledoc """
  Defines the general configuration for the PubNub client
  """
  alias __MODULE__
  defstruct origin: "ps.pndsn.com/",
            publish_key: Application.get_env(:pubnux, :publish_key),
            subscription_key: Application.get_env(:pubnux, :subscription_key),
            is_ssl: Application.get_env(:pubnux, :is_ssl) || false,
            base_url: nil

  @typedoc """
    Represents Config struct
  """
  @type t :: %Config{origin: String.t,
                     publish_key: String.t,
                     subscription_key: String.t,
                     is_ssl: boolean()}

  @doc """
  Choose the http protocol, and defines the base url
  """
  @spec build :: Config.t
  def build, do: %Config{base_url: base_url()}

  @spec build(nil) :: Config.t
  def build(nil) do
    %Config{
      base_url: base_url(),
      publish_key: Application.get_env(:pubnux, :publish_key),
      subscription_key: Application.get_env(:pubnux, :subscription_key),
      is_ssl: (Application.get_env(:pubnux, :is_ssl) || false)
    }
  end

  @spec build(String.t) :: Config.t
  def build(custom_url), do: %Config{base_url: base_url(custom_url)}

  defp base_url do
    protocol = if %Config{}.is_ssl, do: "https://", else: "http://"
    protocol <> %Config{}.origin
  end
  defp base_url(custom_url), do: custom_url
end
