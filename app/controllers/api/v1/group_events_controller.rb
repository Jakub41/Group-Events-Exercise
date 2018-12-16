module Api
  module V1
    class GroupEventsController < Api::V1::ApiController
      helper_method :group_event

      def create
        @group_event = GroupEvent.create!(group_event_params)
      end

      def index
        @group_events = GroupEvent.page(page)
      end

      def show
      end

      def update
        group_event.update!(group_event_params)
      end

      def destroy
        group_event.destroy!
      end

      private

      def group_event
        @group_event ||= GroupEvent.find(params[:id])
      end

      def page
        @page ||= params[:page]
      end

      def group_event_params
        params.require(:group_event).permit(
            :name,
            :description,
            :start_date,
            :end_date,
            :duration,
            :status,
            :latitude,
            :longitude
        )
      end
    end
  end
end
