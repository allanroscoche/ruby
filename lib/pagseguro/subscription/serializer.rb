module PagSeguro
  class Subscription
    class Serializer
      attr_reader :xml

      def initialize(xml)
        @xml = xml
      end

      def serialize
        {}.tap do |data|
          serialize_general(data)
          serialize_sender(data)
        end
      end

      def serialize_general(data)
        data[:code] = xml.css("> code").text
        data[:name] = xml.css("name").text
        data[:date] = xml.css("date").text
        data[:tracker] = xml.css("tracker").text
        data[:charge] = xml.css("charge").text
        data[:reference] = xml.css("reference").text
        data[:last_event_date] = xml.css("lastEventDate").text
        data[:status] = xml.css("> status").text

      end

      def serialize_sender(data)
        sender = {
          name: xml.css("sender > name").text,
          email: xml.css("sender > email").text
        }
        serialize_phone(sender)
        #serialize_address(address)
        data[:sender] = sender
      end


      def serialize_address(data)
        data[:address] = {
          street: xml.css("sender > address > street").text,
          number: xml.css("sender > address > number").text,
          complement: xml.css("sender > address > complement").text,
          district: xml.css("sender > address > district").text,
          postal_code: xml.css("sender > address > postalCode").text,
          city: xml.css("sender > address > city").text,
          state: xml.css("sender > address > state").text,
          country: xml.css("sender > address > country").text,
        }
      end


      def serialize_phone(data)
        data[:phone] = {
          area_code: xml.css("sender > phone > areaCode").text,
          number: xml.css("sender > phone > number").text
        }
      end

    end
  end
end
