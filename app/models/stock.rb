class Stock < ApplicationRecord
  def self.lookup(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:publishable_key],
                                  endpoint: 'https://sandbox.iexapis.com/stable')
    client.price(ticker_symbol)
  end
end