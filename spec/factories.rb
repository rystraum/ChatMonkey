FactoryGirl.define do
  factory :user do |u|
    email "user@domain.com"
    password "pass.1"
    password_confirmation "pass.1"
    remember_me true
    display_name "user name"
  end

  factory :msg do |m|
    message "Lorem ipsum dolor"
  end

  factory :chatroom do |c|
    topic "Subject matter"
  end
end
