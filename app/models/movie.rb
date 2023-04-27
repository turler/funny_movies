class Movie < ApplicationRecord
  belongs_to :user

  default_scope -> { order created_at: :desc }
  scope :available, -> { where available: true }

  validates :link, presence: true
  validate :check_link_youtube

  after_create :update_details

  def update_details
    UpdateMovieDetailsJob.perform_async(id)
  end

  def check_link_youtube
    errors.add(:link, 'is not Youtube URL.') unless valid_url?
  end

  def valid_url?
    uri = URI::parse(link)
    uri.host.present? && uri.host.downcase.include?('youtube.com')
  rescue URI::InvalidURIError
    false
  end
end
