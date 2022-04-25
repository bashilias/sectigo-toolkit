# sectigo-toolkit
Bash application for the Sectigo API

## install
git clone https://github.com/iamilias/sectigo-toolkit
cd sectigo-toolkit && sudo cp sectigokit.sh /usr/local/bin/sectigokit && sudo chmod +x /usr/local/bin/sectigokit

### usage

Syntax: sectigokit [-h|v|s]
options:
h         Print this Help.
v         Validate domain using CNAME 
s         Submit domain validation to Sectigo 

example:

  sectigokit -v github.com
  
