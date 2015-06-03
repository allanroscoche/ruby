module PagSeguro
  class Subscription
    include Extensions::MassAssignment
    include Extensions::EnsureType

    # The subscription name sent by PagSeguro.
    attr_accessor :name

    # The notification code sent by PagSeguro.
    attr_accessor :code

    # The notification code sent by PagSeguro.
    attr_accessor :date

    # The notification code sent by PagSeguro.
    attr_accessor :tracker

    # The notification code sent by PagSeguro.
    attr_accessor :reference

    # The notification code sent by PagSeguro.
    attr_accessor :last_event_date

    # The notification code sent by PagSeguro.
    attr_reader :status

    # The notification code sent by PagSeguro.
    attr_accessor :charge

    # The notification code sent by PagSeguro.
    attr_reader :sender

    # Set the transaction errors.
    attr_reader :errors

    # Set the payment sender.
    def sender=(sender)
      @sender = ensure_type(Sender, sender)
    end

    def status=(status)
      @status = ensure_type(SubscriptionStatus, status)
    end

    def self.find_by_notification_code(code)
      load_from_response send_request("pre-approvals/notifications/#{code}")
    end

    # Serialize the HTTP response into data.
    def self.load_from_response(response) # :nodoc:
      if response.success? and response.xml?
        load_from_xml Nokogiri::XML(response.body).css("preApproval").first
      else
        Response.new Errors.new(response)
      end
    end

    # Serialize the XML object.
    def self.load_from_xml(xml) # :nodoc:
      new Serializer.new(xml).serialize
    end

    # Send a get request to v2 API version, with the path given
    def self.send_request(path)
      Request.get(path, 'v2')
    end

    private
    def after_initialize
      @errors = Errors.new
    end

  end
end
