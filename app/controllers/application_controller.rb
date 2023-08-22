class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 'my_s3cr3t')
    end

    def auth_header
        # { Authorization: 'Bearer <token' }
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
            rescue
                nil
            end
        end

    end

    def current_admin
        if decoded_token
            admin_id = decoded_token[0]['user_id']
            @admin = Admin.find_by(id:admin_id)
        end
    end

    def current_customer
        if decoded_token
          customer_id = decoded_token[0]['user_id']
          @customer = Customer.find_by(id: customer_id)
        end
      end

      
    
      def logged_in?
        !!current_admin || !!current_customer
      end
      def authorized
        if logged_in?
          true
        else
          Rails.logger.info("current_admin: #{current_admin.inspect}")
          Rails.logger.info("current_customer: #{current_customer.inspect}")
          render json: { message: "Please log in" }, status: :unauthorized
        end
      end

end
