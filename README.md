Storedrobe test APP

INSTALL:
1) Install Vagrant and Virtualbox
2) Change into the root of the Storedrobe project app and run 'vagrant up' - (around 10 minutes long)
   - This should install all required dependencies
3) Once the vagrant instance has been provisioned run 'vagrant ssh' to login to the vagrant machine
4) Change into the '/vagrant' directory (cd /vagrant)
5) Install the Storedrobe database by running 'bin/db-migration install' from the project directory
6) Run './storedrobe' to start the Storedrobe app
7) From your browser, go to 'http://localhost:8080/index.html'
8) Choose the sample CSV supplied to upload and click 'Upload' (clothing.csv can also be found in the data/ door in the root of the project)

TODO:
 Write more extensive tests
 Complete frontend for adding/searching/tagging clothing items
