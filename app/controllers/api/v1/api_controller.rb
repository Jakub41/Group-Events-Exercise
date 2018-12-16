# encoding: utf-8

module Api
  module V1
    class ApiController < ApplicationController
      before_action :check_json_request

      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActiveRecord::RecordNotSaved,        with: :render_record_invalid
      rescue_from ActionController::RoutingError,      with: :render_not_found
      rescue_from AbstractController::ActionNotFound,  with: :render_not_found

      def check_json_request
        head :not_acceptable unless request.content_type =~ /json/
      end

      def render_not_found(exception)
        render json: { errors: ['Not Found'] }, status: :not_found
      end

      def render_record_invalid(exception)
        render json: error_json(exception.record.errors), status: :bad_request
      end

      def error_json(errors)
        {
            status: 'error',
            errors: errors.full_messages
        }
      end
    end
  end
end
