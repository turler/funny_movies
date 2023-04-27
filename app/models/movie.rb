class Movie < ApplicationRecord
  default_scope -> { order created_at: :desc }
  scope :available, -> { where available: true }

  validates :link, presence: true, uniqueness: true
  validate :check_link_youtube

  after_create :update_details

  def update_details
    # Background job should be here for performance
    video = VideoInfo.new(link)
    if video.available?
      update(title: video.title, description: video.description,
              available: true, embed_url: video.embed_url, author: video.author)
    end
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
