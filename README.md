Set of scripts to start/stop vApps for test environments so that they're available whenever testers want them.

Works using Confluence Team Calendars (but should work with any calendar that publishes ics subscriber URL).

checkEvent.sh does a curl of the calendar, then uses python script to checkPreview.py to see whether there's a current event in the calendar.

If there's an event it calls the start routine for the vApps, if there's no event it calls the stop routine. If the only response is an error it justds logs.

The start/stop shell script calls a ruby script which use the ruby gem Fog (https://github.com/fog/fog.git) to tell the vCloud Director to deploy and undeploy the vApps.

Fog requires a .fog file in users home directory. Looks a bit like this (user id is rubbish here):

test_credentials:
  vcloud_director_host: 'api.vcd.portal.skyscapecloud.com'
  vcloud_director_username: '1234.12.1a2345@12-34-56-789a1b'
  vcloud_director_password: ''

The password has to be left blank in the .fog file and supplied when the credentials are obtained at the beginning of the start/stop shell script. gorak is used to create spookywooky to provide the password.

The scripts get config data from /etc/carers-fog.conf:

  WIKI_CAL=
  
  VDC_IL2=
  
  VAPP_IL2=
  
  VDC_IL3=
  
  VAPP_IL3=
  
  FOG_USER=
