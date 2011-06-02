Factory.define :blogpost do |b|
  b.id 13
  b.title 'Title'
  b.entry_text 'Entry Text'
  b.user_id 0
end
Factory.define :user do |u|
  u.id 0
  u.name 'John Smith'
  u.email 'john.smith@example.com'
  u.blogposts []
  u.pepper 'pepper'
  u.salt 'salt'
end
