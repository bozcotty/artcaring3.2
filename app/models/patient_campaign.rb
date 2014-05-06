class PatientCampaign < ActiveRecord::Base
  attr_accessible :campaign_name, :artist_relationship_to_patient, :patient_city, :patient_diagnosis, :patient_first_name, :patient_last_name, :patient_state, 
                  :patient_story, :patient_image_1, :patient_street_address, :patient_unit_number, :patient_zip_code, :patient_phone_number, :artist_percentage


  belongs_to :user
  has_many :artworks, dependent: :destroy

  searchable do
    text :campaign_name, :patient_diagnosis, :patient_story, :patient_state, :patient_city, :patient_first_name
  end

  after_create :full_name

  mount_uploader :patient_image_1, PatientImageUploader

  validates :artist_relationship_to_patient, presence: true, length: {maximum: 30}

  validates :patient_city, :patient_state, :patient_story, :patient_image_1, :patient_diagnosis, :patient_zip_code, :patient_phone_number, presence: true

  validates :user_id, uniqueness: true
  validates :user, presence: true

  # validates_associated :artworks

  validates :artist_percentage, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 30 }

  def full_name
    patient_first_name + " " + patient_last_name
  end
  
end
