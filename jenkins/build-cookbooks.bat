RMDIR cookbooks /s/q

cmd /C git clone git@github.com:Zuehlke/cookbooks-jenkins-simple-app.git -b %1 cookbooks

cd cookbooks

cmd /C bundle install

cmd /C berks vendor

cd ..
