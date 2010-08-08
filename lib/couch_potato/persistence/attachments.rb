module CouchPotato
  module Attachments
    def self.included(base) #:nodoc:
      base.class_eval do
        property :_attachments,
          :stringify_name => true

        def _attachments
          @_attachments ||= {}
        end
      end
    end
  end
end
