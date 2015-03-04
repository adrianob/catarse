class ProjectImagesDownloaderWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform project_id
    project = Project.find project_id

    downloader = ImageDownloader.new project
    downloader.download_images
    project.update_columns(about_html: project.about_html.gsub!('/project_id/', "/#{project.id}/"))
  end
end
