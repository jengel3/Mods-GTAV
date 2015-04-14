cd ~/Mods-GTAV
git pull
bundle install
npm install
bower install
rake assets:precompile RAILS_ENV=production
touch tmp/restart.txt