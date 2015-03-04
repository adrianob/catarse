class ImageDownloader
  require 'fileutils'

  def initialize(project)
    @project = project
  end

  def images_urls
    images = []
    @project.about.gsub(/(?<!src=")https?:\/\/.+?\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
      images << match
    end
    images
  end

  def download_images
    images = images_urls
    path = "public/uploads/project/about_images/#{@project.id}/"
    FileUtils.mkdir_p path

    images.each do |image|
      open(path + h(image.split('/').last), 'wb') do |file|
        file << open(image).read
      end
    end
  end
end
