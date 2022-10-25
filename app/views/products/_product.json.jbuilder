json.extract! product, :id, :name, :cost, :volum, :weight, :type, :created_at, :updated_at
json.url product_url(product, format: :json)
