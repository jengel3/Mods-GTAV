require 'faker'

namespace :db do
  desc "Populate a database with real life data"
  task :populate => :environment do
    count = 25
    count.times do 
      pass = Faker::Internet.password
      username = Faker::Internet.user_name(nil, %w(_))[0..13] + rand(100).to_s
      user = User.create!(:username => username, 
        :email => Faker::Internet.email, 
        :encrypted_password => pass, 
        :password => pass)
      
      category = CATEGORIES.keys.sample
      subcategory = CATEGORIES[category].sample

      submission = Submission.create(:creator => user, 
        :name => Faker::Commerce.product_name, 
        :body => Faker::Lorem.paragraph,
        :category => category.downcase,
        :sub_category => subcategory.downcase.gsub(' ', '_'))
      
      image = Image.new(:submission => submission, :location => "Main")
      image.image.store!(File.open(File.join(Rails.root, 'spec', 'data', "thumbnail#{rand 1..7}.jpg")))
      image.save
      
      puts "Created user with username #{user.username} who owns the submission '#{submission.name}' that has an image."
    end
  end
end