module FbJsConnect
  class <<
    def current_fb_connect
      cookie = cookies["fbs_#{FbJsConnect::app_id}"]
      FbJsConnect::Connect.new(cookie)
    end
  end
end