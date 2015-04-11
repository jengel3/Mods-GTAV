require 'faker'

namespace :db do
  desc "Populate a database with real life data"
  task :populate => :environment do
    count = 150
    count.times do
      begin
        pass = Faker::Internet.password
        username = Faker::Internet.user_name(nil, %w(_))[0..13] + rand(100).to_s
        user = User.create!(:username => username, 
          :email => Faker::Internet.email, 
          :encrypted_password => pass, 
          :password => pass)
        
        category = CATEGORIES.keys.sample
        subcategory = CATEGORIES[category].sample

        submission = user.submissions.create!(:name => Faker::Commerce.product_name + rand(1000).to_s, 
          :body => Faker::Lorem.paragraph,
          :category => category.downcase,
          :sub_category => subcategory.downcase.gsub(' ', '_'))
        
        image = submission.images.build(:location => "Main")
        image.image.store!(File.open(File.join(Rails.root, 'spec', 'data', "thumbnail#{rand 1..7}.jpg")))
        image.save

        upload = submission.uploads.build(:version => Faker::App.version, 
          :changelog => Faker::Lorem.paragraph(2))
        upload.upload.store!(File.open(File.join(Rails.root, 'spec', 'data', "uploaded-file.zip")))
        upload.save

        dlcount = rand(200)
        dlcount.times do
          submission.downloads.create!(:ip_address => Faker::Internet.ip_v4_address)
        end
        
        puts "Created user with username #{user.username} who owns the submission '#{submission.name}' that has an image and #{dlcount} downloads."
      rescue
        next
      end
    end
  end
end