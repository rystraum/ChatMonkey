namespace :db do
  desc "Generate default display_names from email"
  task :display_name => :environment do
    User.all.each do |u|
      if u.display_name.blank?
        u.display_name = u.email.split("@").first
        u.save
      end
    end
  end
end

