class CalendarEventsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound , with: :render_not_found_response
  before_action :set_calendar_event, only: %i[ show  update destroy ]

  # GET /calendar_events
  def index
    @calendar_events = CalendarEvent.all
    render json: @calendar_events
  end

  # GET /calendar_events/1
  def show
    render json: set_calendar_event
  end

  # POST /calendar_events
  def create
    @calendar_event = CalendarEvent.new(calendar_event_params)

      if @calendar_event.save
        render json:@calendar_event , status: :created
      else
        render json: @calendar_event.errors.full_messages, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /calendar_events/1
  def update
      if @calendar_event.update(calendar_event_params)
        render json:@calendar_event, status: :ok
      else
        render json: @calendar_event.errors.full_messages, status: :unprocessable_entity 
      end
  end

  # DELETE /calendar_events/1
  def destroy
    @calendar_event.destroy
      head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_event
      @calendar_event = CalendarEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calendar_event_params
      params.require(:calendar_event).permit(:appointment_id, :start_time, :end_time, :title, :description)
    end

    def render_not_found_response
      render json:{error: "Event not found"}, status: :not_found
    end
end
