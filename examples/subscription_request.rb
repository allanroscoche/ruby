# -*- encoding : utf-8 -*-
require_relative "boot"

payment = PagSeguro::SubscriptionRequest.new
payment.abandon_url = "http://dev.simplesideias.com.br/?abandoned"
payment.notification_url = "http://dev.simplesideias.com.br/?notification"
payment.redirect_url = "http://dev.simplesideias.com.br/?redirect"
payment.reference = "REF1234"

payment.pre_approval = {
  charge: "auto",
  name: "Nando Vieira",
  details: "assinatura dr",
  amount_per_payment: "5.00",
  period: "Monthly",
  final_date: "2016-01-21T00:00:000-03:00",
  max_total_amount: "2000.00"
}
# Add extras params to request
# payment.extra_params << { paramName: 'paramValue' }
# payment.extra_params << { senderBirthDate: '07/05/1981' }
# payment.extra_params << { extraAmount: '-15.00' }

puts "=> REQUEST"
puts PagSeguro::SubscriptionRequest::Serializer.new(payment).to_params

response = payment.register

puts
puts "=> RESPONSE"
puts response.url
puts response.code
puts response.created_at
puts response.errors.to_a
