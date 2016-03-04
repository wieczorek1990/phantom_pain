require 'tor'

class Tor::Controller
  def signal(name)
    send_command :signal, name
    read_reply
  end

  def restart
    signal :newnym
  end
end

