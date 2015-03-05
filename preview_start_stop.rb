#!/usr/bin/ruby
# ARGV[0] = user id
# ARGV[1] = start /stop
# ARGV[2] = VDC Name
# ARGV[3] = VAPP ID

require 'fog'

@vcloud = Fog::Compute::VcloudDirector.new(
      :vcloud_director_username => ARGV[0],
      :vcloud_director_password => "",
      :vcloud_director_host => "api.vcd.portal.skyscapecloud.com",
      :vcloud_director_show_progress => false, # task progress bar on/off
    )

@vcloud.organizations.first.vdcs.get_by_name(ARGV[2]).vapps.each do |vapp|
  if vapp.id == ARGV[3] then
#
#    power on only powers on the app, use deploy instead to start the app "properly"
#    response = @vcloud.post_power_on_vapp(vapp.id)
#
    if ARGV[1] == "start" then
      response = @vcloud.post_deploy_vapp(vapp.id)
    else
      response = @vcloud.post_undeploy_vapp(vapp.id)
    end
    task = @vcloud.get_task(response[:body][:href].split('/').last)
    puts task[:body]
    if ARGV[1] == "start" then
      puts "Powered On #{vapp.id}"
    else
      puts "Powered Off #{vapp.id}"
    end
  end
end

