json.array!(@answs) do |answ|
  json.extract! answ, :id
  json.url answ_url(answ, format: :json)
end
