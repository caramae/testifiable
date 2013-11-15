json.array!(@experiments) do |experiment|
  json.extract! experiment, :action, :control, :outcome, :unit
  json.url experiment_url(experiment, format: :json)
end