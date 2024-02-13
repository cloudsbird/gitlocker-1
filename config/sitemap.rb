# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.gitlocker.com"

SitemapGenerator::Sitemap.public_path = "tmp/"

SitemapGenerator::Sitemap.create(compress: false) do
  add root_path
end
