class AppointmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound , with: :render_not_found_response
    before_action :set_appointment, only: %i[ show edit update destroy ]
  
    # GET /appointments or /appointments.json
    def index
      @appointments = Appointment.all
      render json: @appointments
    end
  
    # GET /appointments/1
    def show
      render json: set_appointment
    end
  
    # GET /appointments/new
    def new
      @appointment = Appointment.new
    end
  
    # GET /appointments/1/edit
    def edit
    end
  
    # POST /appointments 
    # def create
    #   @appointment = Appointment.new(appointment_params)
  
    #     if @appointment.save
    #       render json: @appointment, status: :created
    #     else
    #       render json: @appointment.errors.full_messages, status: :unprocessable_entity 
    #     end
    # end
  
    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        create_calendar_event(@appointment)
        render json: @appointment, status: :created
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /appointments/1
    def update
        if @appointment.update(appointment_params)
          render json: @appointment, status: :ok
        else
          render json: @appointment.errors.full_messages, status: :unprocessable_entity 
        end
    end
  
    # DELETE /appointments/1 
    def destroy
      @appointment.destroy
  
      head :no_content
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_appointment
        @appointment = Appointment.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def appointment_params
        params.require(:appointment).permit(:customer_id, :service_id, :start_time, :end_time, :confirmed)
      end

      def render_not_found_response
        render json:{error: "Appointment not found"}, status: :not_found
      end

       def create_calendar_event(appointment)
    CalendarEvent.create(
      appointment_id: appointment.id,
      start_time: appointment.start_time,
      end_time: appointment.end_time,
      title: "Appointment",
      description: "Appointment with Jay"
    )
  end
end

  