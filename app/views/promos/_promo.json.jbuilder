json.extract! promo, :id, :name, :sale, :quantity, :created_at, :updated_at
json.url promo_url(promo, format: :json)
