RMDIR cookbooks /s/q

cmd /C git clone https://github.com/Zuehlke/cookbooks-jenkins-simple-app.git cookbooks

cd cookbooks

cmd /C bundle install

cmd /C berks vendor

cd ..
