class Movie < ApplicationRecord
  validates :link, presence: true

  after_create :update_details

  def update_details
    # Background job should be here for performance
    video = VideoInfo.new(link)
    update(title: video.title, description: video.description, available: true) if video.available?
  end
end
