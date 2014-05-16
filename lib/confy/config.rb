module Confy

  class Config

    def self.new(url = {})

      if url.is_a?(String)
        regex = Regexp.new('(https?:\/\/)(.*):(.*)@(.*)\/orgs\/([a-z0-9]*)\/projects\/([a-z0-9]*)\/envs\/([a-z0-9]*)\/config', true)
        matches = regex.match(url)

        url = {
          :host => matches[1] + matches[4], :user => matches[2], :pass => matches[3],
          :org => matches[5], :project => matches[6], :env => matches[7]
        }
      end

      client = Confy::Client.new({
        :username => url[:user], :password => url[:pass]
      }, { :base => url[:host] })

      client.config(url[:org], url[:project], url[:env]).retrieve().body
    end

  end

end