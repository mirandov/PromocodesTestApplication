json.extract! order, :id, :description, :price, :promo_id, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
