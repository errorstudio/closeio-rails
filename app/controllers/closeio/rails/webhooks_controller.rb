module Closeio
  module Rails
    class WebhooksController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create]

      # def closeio
      #   if params[:model] == 'lead'
      #     SyncUsersJob.perform_later params[:data][:id]
      #   end
      #   head :ok
      # end

      def create
        request.format = :json
        event = params[:event]
        ActiveSupport::Notifications.instrument("closeio.#{event[:action]}", event)

        #must return an ok - check Rails version to determine whether to return nothing or head response.
        if ::Rails.version =~ /^4/
          render nothing: true
        else
          head :ok
        end
      end

      def debug
        render json: {response: "It works - this is the debug method in Closeio::Rails::WebhooksController"}
      end
    end
  end
end
