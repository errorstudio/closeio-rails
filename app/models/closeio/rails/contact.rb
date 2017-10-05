module Closeio
  module Rails
    class Contact < Base

      def has_login?
        emails.find {|e| e['type'] == 'other'}.present?
      end

      def email
        raise NotImplementedError, "You need to implement Closeio::Rails::Contact#email in your own subclass or prepended mixin."
      end

      def phone_numbers
        phones.inject({}) {|h, p| h[p['phone_formatted']] = p['type']; h}
      end

      def email_addresses
        emails.inject({}) {|h,data| h[data[:email]] = data[:type]; h}
      end
    end
  end
end
