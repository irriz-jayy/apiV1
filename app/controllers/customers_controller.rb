class CustomersController < ApplicationController
    before_action :set_customer, only: %i[ show edit update destroy ]
    rescue_from ActiveRecord::RecordNotFound , with: :render_not_found_response
    skip_before_action :authorized, only: [:create] 

  
    # GET /customers 
    def index
      @customers = Customer.all
      render json: @customers
    end
  
    # GET /customers/1
    def show
      render json:set_customer 
    end
  
    # POST /customers/
    def new
      @customer = Customer.new
    end
  
    # PATCH /customers/1/
    def edit
    end
  
    # POST /customers
    def create
      @customer = Customer.new(customer_params)
    
      if @customer.save
        token = encode_token(customer_id:@customer.id)
        render json: {customer: @customer, jwt:token},  status: :created
      else
        render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def profile
      render json: @customer
    end
    
  
    # PATCH/PUT /customers/1
    def update
        if @customer.update(customer_params)
          render json: @customer, status: :ok
        else
         render json: @customer.errors, status: :unprocessable_entity 
        end
    end
  
    # DELETE /customers/1 
    def destroy
      @customer.destroy
      head :no_content 
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def customer_params
        params.require(:customer).permit(:first_name, :surname, :email, :phone_number, :password)
      end

      def render_not_found_response
        render json:{error: "Customer not found"}, status: :not_found
      end
  end
  