class UpdateMovieDetailsJob
  include Sidekiq::Job

  def perform(movie_id)
    movie = Movie.find(movie_id)
    video = VideoInfo.new(movie.link)
    if video.available?
      movie.update(title: video.title, description: video.description, available: true, embed_url: video.embed_url, author: video.author)
    end
    movie.broadcast_prepend_to('movies')
  end
end
