Factory.define :user do |u|
  u.email "user@domain.com"
  u.password "pass.1"
  u.password_confirmation "pass.1"
  u.remember_me true
  u.display_name "user name"
end

Factory.define :msg do |m|
  m.message "Lorem ipsum dolor"
end

Factory.define :chatroom do |c|
  c.topic "Subject matter"
end
