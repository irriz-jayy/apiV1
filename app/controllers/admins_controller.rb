class AdminsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound , with: :render_not_found_response
    before_action :set_admin, only: %i[ show  update destroy ]
  
    # GET /admins or /admins.json
    def index
      @admins = Admin.all
      render json:@admins
    end
  
    # GET /admins/1
    def show
      render json: set_admin
    end
  
  
    # POST /admins
    def create
      @admin = Admin.new(admin_params)
  
        if @admin.save
          render json:@admin, status: :created
        else
          render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    # PATCH/PUT /admins/1
    def update
        if @admin.update(admin_params)
          render json:@admin, status: :ok
        else
          render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    # DELETE /admins/1
    def destroy
      @admin.destroy
      head :no_content
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin
        @admin = Admin.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def admin_params
        params.require(:admin).permit(:first_name, :surname, :email, :password)
      end
  
      def render_not_found_response
        render json:{error: "Admin not found"}, status: :not_found
      end
end
  