module FbJsConnect
  class Connect
    # When using the Facebook Javascript SDK to connect users to your site, 
    # a cookie will be placed in your applications session store. This class
    # will verify your cookie, tell you if you're connected, and provide
    # you with a User and other information

    # Verification works by combining cookie key + values, minus sig, 
    # appending app_secret, then MD5 hashing it.
    # The value of the MD5 should equal the sig value.

    attr_accessor :connected
    
    def initialize(cookie)
      fb_cookie = cookie
      if fb_cookie
        # remove any quotes in cookie. Facebook puts it's cookie in
        # quotes for some reason
        fb_cookie.gsub!('"','')
        # split cookie values into array by '&' symbol
        fb_cookie = fb_cookie.split("&")
        fb_cookie_hash = Hash.new
        fb_cookie.each do |c, i|
    	 key_value_arr = c.split("=") # split value into kv hash
    	 fb_cookie_hash[key_value_arr[0]] = key_value_arr[1] # add to new hash
        end

        @fb_cookie_hash = fb_cookie_hash # for verification

        # apply connected and fb_cookie_hash to class attributes IF verified
        if self.verified?
          @attributes = fb_cookie_hash 
          self.connected = true
        end
      else
        # no cookie found so return false
        self.connected = false
        return false
      end
    end

    def verified?
      Rails.logger.debug("\nFB: digested sig: #{process}")
      Rails.logger.debug("FB: sig: #{@sig}\n\n")
      if process == @sig
        return true
      else
        return false
      end
    end

    def method_missing(name, *args)
      attribute = name.to_s
      if attribute =~ /=$/
        @attributes[attribute.chop] = args[0]
      else
        @attributes[attribute]
      end
    end

    private
    def process
      @sig = @fb_cookie_hash['sig'] # get sig to compare final hash
      payload = []
      @fb_cookie_hash.each do |k, v|
        payload.push "#{k}=#{v}" unless k == "sig"
      end
      digest = Digest::MD5.hexdigest(payload.sort.to_s + 
        FbJsConnect::app_secret)
      return digest
    end

  end
end