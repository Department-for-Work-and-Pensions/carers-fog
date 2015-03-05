#!/bin/sh

MY_CRED=`./spookywooky|FOG_CREDENTIAL=test_credentials vcloud-login`
echo "My Cred: ${MY_CRED}"
eval ${MY_CRED}
echo "vCloud token: ${FOG_VCLOUD_TOKEN}"

#eval $(FOG_CREDENTIAL=test_credentials vcloud-login)
FOG_CREDENTIAL=test_credentials vcloud-walk vdcs 
