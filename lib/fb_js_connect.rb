require 'digest/md5'
require 'fb_js_connect/connect'
require 'fb_js_connect/base'

module FbJsConnect
  
  class << self
    attr_accessor :app_id, :app_secret
    
    def load_config(yaml_file)
      return false unless File.exist?(yaml_file)
      @config =  YAML.load(ERB.new(File.read(yaml_file)).result)
      apply_config(@config)
    end
    
    def apply_config(config)
      self.app_id = config['app_id']
      self.app_secret = config['app_secret']
    end
    
  end
  
  load_config("#{Rails.root}/config/fb_credentials.yml")
  
end
