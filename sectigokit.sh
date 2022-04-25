#!/bin/bash

########################
#DECLARE YOUR VARIABLE #
######################## 
SECTIGO_USER=
SECTIGO_PASS=
SECTIGO_CUSTOMER_URI=

#Colors
RED='\033[0;31m'
NC='\033[0m'

Help()
{
   # Display Help
   echo "Sectigo Toolkit"
   echo
   echo "Syntax: sectigokit [-h|v|s]"
   echo "options:"
   echo "h         Print this Help."
   echo "v         Validate domain using CNAME "
   echo "s         Submit domain validation to Sectigo "
   echo
}


ValidateCname()
{
   curl -s 'https://cert-manager.com/api/dcv/v1/validation/start/domain/cname' -i -X POST \
   -H 'Content-Type: application/json' \
   -H 'login: '$SECTIGO_USER'' \
   -H 'password: '$SECTIGO_PASS'' \
   -H 'customerUri: '$SECTIGO_CUSTOMER_URI'' \
   -d '{"domain":"'$DOMAIN'"}' \
   | grep host > .data

   HOST=$(jq -r '.host' .data)
   TARGET=$(jq -r '.point' .data)

   echo "Please create CNAME Record for $DOMAIN:"
   echo " "
   echo -e "${RED}Record name: ${NC} $HOST"
   echo -e "${RED}Target: ${NC} $TARGET" 
   echo " "
}

SubmitValidation()
{
   curl -s 'https://cert-manager.com/api/dcv/v1/validation/submit/domain/cname' -i -X POST \
   -H 'Content-Type: application/json' \
   -H 'login: '$SECTIGO_USER'' \
   -H 'password: '$SECTIGO_PASS'' \
   -H 'customerUri: '$SECTIGO_CUSTOMER_URI'' \
   -d '{"domain":"'$DOMAIN'"}' \
   | grep status > .validation

   STATUS=$(jq -r '.status' .validation)
   ORDER_STATUS=$(jq -r '.orderStatus' .validation)
   SUBMIT_MESSAGE=$(jq -r '.message' .validation)
            
    
   echo -e "${RED}Status: ${NC} $STATUS"
   echo -e "${RED}Order Status: ${NC} $ORDER_STATUS"
   echo -e "$SUBMIT_MESSAGE"
}



########################
# START OF APPLICATION #
######################## 

while getopts ":hv:s:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      v)
         DOMAIN="$OPTARG"
         ValidateCname
         exit;;
      s)
         DOMAIN="$OPTARG"
         SubmitValidation
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done
shift "$(($OPTIND -1))"
