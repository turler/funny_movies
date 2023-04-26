class Movie < ApplicationRecord
  default_scope -> { order created_at: :desc }
  scope :available, -> { where available: true }

  validates :link, presence: true

  after_create :update_details

  def update_details
    # Background job should be here for performance
    video = VideoInfo.new(link)
    if video.available?
      update(title: video.title, description: video.description,
              available: true, embed_url: video.embed_url, author: video.author)
    end
  end
end
