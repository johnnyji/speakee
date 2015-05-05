json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.user_id comment.user_id
  json.confession_id comment.confession_id
end