json.array!(@experiments) do |experiment|
  json.extract! experiment, :action, :control
  json.url experiment_url(experiment, format: :json)
end