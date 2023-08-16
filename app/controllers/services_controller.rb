class ServicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound , with: :render_not_found_response
    before_action :set_service, only: %i[ show edit update destroy ]
  
    # GET /services or /services.json
    def index
      @services = Service.all
      render json: @services
    end
  
    # GET /services/1 or /services/1.json
    def show
      render json: set_service
    end
  
    # GET /services/new
    def new
      @service = Service.new
    end
  
    # GET /services/1/edit
    def edit
    end
  
    # POST /services
    def create
      @service = Service.new(service_params)
  
        if @service.save
          render json: @service, status: :created
        else
          render json: @service.errors.full_messages, status: :unprocessable_entity 
        end
    end
  
    # PATCH/PUT /services/1 
    def update
        if @service.update(service_params)
          render json: @service, status: :ok
        else
          render json: @service.errors.full_messages, status: :unprocessable_entity
        end
    end
  
    # DELETE /services/1
    def destroy
      @service.destroy
      head :no_content 
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service
        @service = Service.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def service_params
        params.require(:service).permit(:name, :price)
      end

      def render_not_found_response
        render json:{error: "Service not found"}, status: :not_found
      end
  end
  
  