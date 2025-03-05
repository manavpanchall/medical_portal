# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :role, inclusion: { in: %w[receptionist doctor] }
    
    def receptionist?
      role == 'receptionist'
    end
    
    def doctor?
      role == 'doctor'
    end
  end
  
  # app/models/patient.rb
  class Patient < ApplicationRecord
    belongs_to :registered_by, class_name: 'User'
    
    validates :first_name, :last_name, :date_of_birth, presence: true
    
    def full_name
      "#{first_name} #{last_name}"
    end
    
    def self.search(term)
      return all if term.blank?
      where("lower(first_name) LIKE ? OR lower(last_name) LIKE ?", 
            "%#{term.downcase}%", "%#{term.downcase}%")
    end
  end