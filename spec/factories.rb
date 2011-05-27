Factory.define :blogpost do |b|
  b.id 13
  b.title 'Title'
  b.entry_text 'Entry Text'
  b.user_id 13
end
Factory.define :user do |u|
  u.id 13
  u.name 'John Smith'
  u.email 'john.smith@example.com'
  u.blogposts []
end
