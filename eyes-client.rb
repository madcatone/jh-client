# usage: rest-client / thread
# author: JhHung by 2016 02 17
require 'awesome_print'
require 'rest-client'
require 'roo'
require 'yaml'

#xlsx = Roo::Spreadsheet.open('/home/hch/12-21.xlsx.xlsx')
lz = []
start = Time.now
#模拟线程操作
threads = []
n = !ARGV[4].empty? ? ARGV[4].to_i : 1

def import_xlsx(xlsx)
  2.upto(3) do |i|
    #xlsx.sheets(0).row(i).each do |pw|
    #p xlsx.sheet(0).row(i)
    ##lz << xlsx.sheet(0).row(i)
    #send_with_xlsx(xlsx.sheet(0).row(i)) if ARGV[3] == '1'
    ##threads << Thread.new { send_with_xlsx(xlsx.sheet(0).row(i)) } if ARGV[3] == '1'
    ##sleep(0.3)
    #z << pw
    #p z
    #p z.size
      #threads << Thread.new { send_with_xlsx(z) } if ARGV[3] == '1'
    #end
  end
  #ap lz
end
def send_with_xlsx(z)
   response = RestClient.post platform()+'fatigue_alarms',
     :user_id => 3,
     :location =>z[5],
     :location_lng =>z[3],
     :location_lat =>z[4],
     :sim_number =>z[22],
     :current_at =>z[2],
     :speed =>"0.0",
     :gps_speed => z[12],
     :alarm_type =>z[21],
     #:attachment => File.new("/home/hch/demo.jpg", 'rb')
     :acceleration =>z[23],
     :x_acceleration =>z[24],
     :y_acceleration =>z[25],
     :z_acceleration =>z[26],
     :license_plate_number =>z[0]
   ap "#{strftime(Time.now)}==code:#{response.code}==response_time:#{response.headers[:x_runtime]}"
end

def send_with_pic
   response = RestClient.post platform()+'fatigues',
     :location_lng => rand_lng(),
     :location_lat => rand_lat(),
     :sim_number => sim(),
     :current_at =>"#{Time.now}",
     :speed =>"0.0",
     :alarm_type =>"fatigue",
     :attachment => File.new("/home/hch/571.jpg", 'rb')
   ap "#{strftime(Time.now)}==code:#{response.code}==response_time:#{response.headers[:x_runtime]}"
end

def send_without_pic
   response = RestClient.post platform()+'fatigues',
     :location_lng => rand_lng(),
     :location_lat => rand_lat(),
     :sim_number => sim(),
     :current_at =>"#{Time.now}",
     :speed =>"0.0",
     :alarm_type =>"none"
   ap "#{strftime(Time.now)}==code:#{response.code}==response_time:#{response.headers[:x_runtime]}"
end

def send_errorlog
   response = RestClient.post platform()+'errorlogs',
     :sim_number => sim(),
     :log => yml_config()['log'][rand(6)]
   ap "#{strftime(Time.now)}==code:#{response.code}==response_time:#{response.headers[:x_runtime]}"
end

def platform
  dev = yml_config()['platform']['dev']
  pro = yml_config()['platform']['pro']
  ARGV[3] == 'pro' ? pro : dev
end

def sim
  ARGV[3] == 'pro' ? yml_config()['sim']['pro'] : yml_config()['sim']['dev']
end

def rand_lng
  '121.' + rand(1000000).to_s
end
def rand_lat
  '31.' + rand(1000000).to_s
end

def strftime(time)
  time.strftime('%Y-%m-%d %H:%M:%S')
end

def yml_config
  config = YAML.load_file('data.yml')
end

#### main ####
n.times do
   # n = n+1
   # if n.to_s[1..3]== "00"

   #    threads << Thread.new { send }
   
   # else
      # threads << Thread.new { send }
   # end
   threads << Thread.new { send_with_pic } if ARGV[0] == '1'
   threads << Thread.new { send_without_pic } if ARGV[1] == '1'
   threads << Thread.new { send_errorlog } if ARGV[2] == '1'
   #threads << Thread.new { send_with_xlsx } if ARGV[3] == '1'
   sleep(1)
end
threads.each { |t| t.join }
ap "Total use:#{Time.now - start} sec"
ap n
#ap yml_config()['last_update']



