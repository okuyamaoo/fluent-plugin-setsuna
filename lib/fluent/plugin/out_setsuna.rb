#<match setsuna>
#  type setsuna
#  serveraddr 192.168.33.24
#  serverport 8080
#  unixtimeuse True
#</match>
require 'net/http'
require 'uri'

class Fluent::SetsunaOutput < Fluent::Output
  Fluent::Plugin.register_output('setsuna', self)

  include Fluent::SetTagKeyMixin
  config_set_default :include_tag_key, false

  include Fluent::SetTimeKeyMixin
  config_set_default :include_time_key, true


  # config_param :setsuna, :string, :default => 'setsuna'

  def configure(conf)
    super

    @serverAddr = conf['serveraddr']
    @serverPort = conf['serverport']
    @unixtimeUseStr = conf['unixtimeuse']
    @unixtimeUseStr = @unixtimeUseStr.downcase
    @unitimeUse = false
    if @unixtimeUseStr == "true" then
      @unitimeUse = true
    end
  end

  def start
    super
    # init
  end

  def shutdown
    super
    # destroy
  end
  
  def emit(tag, es, chain)
    chain.next

    es.each {|time,record|
      $stderr.puts time
      sep = ""
      urlParam = ""
      record.each{|key, value|
        urlParam = urlParam + sep + key + "=" + URI.encode(value)
        sep = "&"
      }
      if @unitimeUse == true then
        request = Net::HTTP::Get.new('/?requesttime=' + time.to_s + "&" + urlParam)
      else 
        request = Net::HTTP::Get.new('/?' + urlParam)
      end

      response = Net::HTTP.start(@serverAddr, @serverPort) {|http|
        http.request(request)
      }
    }
  end
end