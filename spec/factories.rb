Factory.define :blogpost do |b|
  b.title 'Title'
  b.entry_text 'Entry Text'
  b.user_id 1
end
Factory.define :user do |u|
  u.id 1
  u.name 'John Smith'
  u.email 'john.smith@example.com'
  u.blogposts []
end
