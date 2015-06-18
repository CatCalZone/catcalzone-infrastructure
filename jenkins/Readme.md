
== Prerequisite ==
* Get a pair of (aws_access_key, aws_secret_key)
* Setup new key-pair in Amazon AWS Console (e.g. https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#KeyPairs:sort=keyName)
* Download private key to this project folder (e.g. user.pem)

== Create variables file ==
* Create terraform.tfvars as a copy of terraform.tfvars.example
* Fill in
** aws_access_key
** aws_secret_key
** aws_key_name (e.g. user.pem)

== Provision a jenkins server ==

run 'provision.bat <branch>'

while <branch> is a valid branch of cookbooks-jenkins-simple-app, e.g. master
