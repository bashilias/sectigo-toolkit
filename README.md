# Sectigo-toolkit
Bash application for the Sectigo API

## Install
git clone https://github.com/iamilias/sectigo-toolkit
cd sectigo-toolkit && sudo cp sectigokit.sh /usr/local/bin/sectigokit && sudo chmod +x /usr/local/bin/sectigokit

### Usage

Add your Sectigo username, password and customer uri to sectigokit.sh

Syntax: sectigokit [-h|v|s]
options:
h         Print this Help.
v         Validate domain using CNAME 
s         Submit domain validation to Sectigo 

example:
  sectigokit -v github.com
  
