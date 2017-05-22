defmodule PubNux.Client do
  @moduledoc """
  Defines the structure of the PubNub client
  """
  alias __MODULE__
  defstruct origin: "pubsub.pubnub.com",
            publish_key: Application.get_env(:pubnux, :publish_key),
            subscription_key: Application.get_env(:pubnux, :subscription_key),
            is_ssl: Application.get_env(:pubnux, :is_ssl) || false,
            base_url: nil

  @typedoc """
    Represents Client struct with the PubNub API client
  """
  @type t :: %Client{origin: String.t,
                    publish_key: String.t,
                    subscription_key: String.t,
                    is_ssl: boolean()}

  @spec build() :: Client.t
  def build() do
    %Client{base_url: base_url()}
  end

  def base_url do
    protocol = if %Client{}.is_ssl, do: "https://", else: "http://"

    protocol <> %Client{}.origin
  end
end