json.array!(@datapoints) do |datapoint|
  json.extract! datapoint, :experiment_id, :user_id, :value, :iv_value, :compliance
  json.url datapoint_url(datapoint, format: :json)
end