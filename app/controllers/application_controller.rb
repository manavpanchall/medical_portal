# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    
    private
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    helper_method :current_user
    
    def logged_in?
      !current_user.nil?
    end
    
    def authenticate_user!
      unless logged_in?
        flash[:error] = "Please log in first"
        redirect_to login_path
      end
    end
  end
  
  # app/controllers/receptionist/patients_controller.rb
  class Receptionist::PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_receptionist_role
    
    def index
      @patients = Patient.all.order(created_at: :desc)
    end
    
    def show
      @patient = Patient.find(params[:id])
    end
    
    def new
      @patient = Patient.new
    end
    
    def create
      @patient = Patient.new(patient_params.merge(registered_by: current_user))
      
      if @patient.save
        redirect_to receptionist_patients_path, notice: 'Patient registered successfully'
      else
        render :new
      end
    end
    
    def edit
      @patient = Patient.find(params[:id])
    end
    
    def update
      @patient = Patient.find(params[:id])
      
      if @patient.update(patient_params)
        redirect_to receptionist_patients_path, notice: 'Patient updated successfully'
      else
        render :edit
      end
    end
    
    def destroy
      @patient = Patient.find(params[:id])
      @patient.destroy
      redirect_to receptionist_patients_path, notice: 'Patient record deleted'
    end
    
    private
    
    def patient_params
      params.require(:patient).permit(
        :first_name, :last_name, :date_of_birth, :contact_number
      )
    end
    
    def ensure_receptionist_role
      redirect_to root_path unless current_user.receptionist?
    end
  end
  
  # app/controllers/doctor/analytics_controller.rb
  class Doctor::AnalyticsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_doctor_role
    
    def index
      @patients = Patient.all.order(created_at: :desc)
      
      # Prepare data for graph
      @registration_data = Patient.group_by_day(:created_at).count
      
      respond_to do |format|
        format.html
        format.json { render json: @registration_data }
      end
    end
    
    private
    
    def ensure_doctor_role
      redirect_to root_path unless current_user.doctor?
    end
  end