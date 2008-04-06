module ActionMessager
  class Base
    include ActionController::UrlWriter if Object.const_defined?(:ActionController)

    class_inheritable_accessor :jabber_settings
    
    class << self
      def connection
        raise ArgumentError.new('You must supply jabber credentials to use ActionMessager') unless [jabber_settings[:username], jabber_settings[:password]].select(&:blank?).empty?
        @connection ||= Jabber::Simple.new(jabber_settings[:username], jabber_settings[:password])
      end
      
      def method_missing(method, *args)
        method.to_s =~ /deliver_.+?/ ? deliver(method.to_s.gsub(/deliver_/, '').intern, *args) : super
      end
      
      def deliver(method, *args)
        messager = new
        msg      = messager.send(method, *args)
        
        messager.recipients.each do |recipient|
          connection.deliver recipient, msg
        end
      end

      private :new
    end
    
    attr_accessor :recipients
  end
end
