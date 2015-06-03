module PagSeguro
  class SubscriptionStatus
    STATUSES = {
      "PENDING" => :pending,
      "ACTIVE" => :active,
      "CANCELLED" => :cancelled,
      "CANCELLED_BY_RECEIVER" => :cancelled_by_receiver,
      "CANCELLED_BY_SENDER" => :cancelled_by_sender,
      "EXPIRED" => :expired
    }.freeze

    # The payment status id.
    attr_reader :id

    def initialize(id)
      @id = id
    end

    # Dynamically define helpers.
    STATUSES.each do |id, _status|
      define_method "#{_status}?" do
        _status == status
      end
    end

    # Return a readable status.
    def status
      STATUSES.fetch(id.to_s) { raise "PagSeguro::Subscription#id isn't mapped" }
    end
  end
end
