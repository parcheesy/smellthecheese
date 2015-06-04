json.array!(@articles) do |article|
  json.extract! article, :id, :title, :date, :body, :imagePath
  json.url article_url(article, format: :json)
end
