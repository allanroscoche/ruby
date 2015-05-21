module PagSeguro
  class SubscriptionRequest
    class Serializer
      # The payment request that will be serialized.
      attr_reader :payment_request

      def initialize(payment_request)
        @payment_request = payment_request
      end

      def to_params
        params[:receiverEmail] = PagSeguro.receiver_email
        params[:currency] = payment_request.currency
        params[:reference] = payment_request.reference
        params[:redirectURL] = payment_request.redirect_url
        params[:notificationURL] = payment_request.notification_url
        params[:abandonURL] = payment_request.abandon_url
        params[:maxUses] = payment_request.max_uses
        params[:maxAge] = payment_request.max_age


        serialize_sender(payment_request.sender)
        serialize_pre_approval(payment_request.pre_approval)
        serialize_extra_params(payment_request.extra_params)

        params.delete_if {|key, value| value.nil? }

        params
      end

      private
      def params
        @params ||= {}
      end

      def serialize_sender(sender)
        return unless sender

        params[:senderEmail] =  sender.email
        params[:senderName] = sender.name
        params[:senderCPF] = sender.cpf

        serialize_phone(sender.phone)
      end

      def serialize_pre_approval(pre_approval)
        return unless pre_approval

        params[:preApprovalCharge] = pre_approval.charge
        params[:preApprovalName] = pre_approval.name
        params[:preApprovalDetails] = pre_approval.details
        params[:preApprovalAmountPerPayment] = pre_approval.amount_per_payment
        params[:preApprovalPeriod] = pre_approval.period
        params[:preApprovalFinalDate] = pre_approval.final_date
        params[:preApprovalMaxTotalAmount] = pre_approval.max_total_amount

      end

      def serialize_phone(phone)
        return unless phone

        params[:senderAreaCode] = phone.area_code
        params[:senderPhone] = phone.number
      end

      def serialize_address(address)
        return unless address

        params[:shippingAddressCountry] = address.country
        params[:shippingAddressState] = address.state
        params[:shippingAddressCity] = address.city
        params[:shippingAddressPostalCode] = address.postal_code
        params[:shippingAddressDistrict] = address.district
        params[:shippingAddressStreet] = address.street
        params[:shippingAddressNumber] = address.number
        params[:shippingAddressComplement] = address.complement
      end

      def serialize_extra_params(extra_params)
        return unless extra_params

        extra_params.each do |extra_param|
          params[extra_param.keys.first] = extra_param.values.first
        end
      end

      def to_amount(amount)
        "%.2f" % BigDecimal(amount.to_s).round(2).to_s("F") if amount
      end
    end
  end
end
