json.array!(@annotations) do |annotation|
  json.extract! annotation, :id, :x-axis, :y-axis, :details, :image_id
  json.url annotation_url(annotation, format: :json)
end
