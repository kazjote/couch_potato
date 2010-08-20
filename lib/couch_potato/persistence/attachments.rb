module CouchPotato
  module Attachments
    def self.included(base) #:nodoc:
      base.class_eval do
        property :_attachments

        def _attachments
          @_attachments ||= {}
        end
      end
    end
  end
end
