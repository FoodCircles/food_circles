Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, '55FkOZwwBFlmo1heQYpdCA', 'm2qJp8pvUbCKB19Zm0h5TXx1yjq6fAWRH7PN6S7vU'
  provider :facebook, '130899700304680', 'f6130e1e67aa3e9cd26293cb4274e5e1', {:provider_ignores_state => true}
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
