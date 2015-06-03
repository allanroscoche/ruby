require_relative "boot"

subscription = PagSeguro::Subscription.find_by_notification_code("1E67BCF60E030E030B2CC4514FA73E0DCC90")

puts "=> Transaction"
puts "  code: #{subscription.code}"
puts "  name: #{subscription.name}"
puts "  status: #{subscription.status.status}"
puts "  date: #{subscription.date}"
puts "  tracker: #{subscription.tracker}"
puts "  reference: #{subscription.reference}"
puts "  charge: #{subscription.charge}"
puts "  lastEventDate: #{subscription.last_event_date}"


puts "    => Sender"
puts "      name: #{subscription.sender.name}"
puts "      email: #{subscription.sender.email}"
puts "      phone: (#{subscription.sender.phone.area_code}) #{subscription.sender.phone.number}"
