require 'catalog-client'
require 'byebug'

class CatalogService
  CATALOG_OBJECTS = {
      store:    'stores',
      category: 'categories',
      product:  'products'
  }

  CATALOG_OBJECTS.keys.each do |name|
    define_singleton_method(name) do |id|
      client.send(name, id)
    end

    define_singleton_method(CATALOG_OBJECTS[name].to_sym) do
      client.send(CATALOG_OBJECTS[name].to_sym)
    end
  end

  private

  def self.client
    raise 'Catalog client configuration missing. \
          Check \'CATALOG_SERVICE_URL\' environment setting.' unless ENV['CATALOG_SERVICE_URL'].present?
    @@client ||= CatalogClient::Wrapper.new(ENV['CATALOG_SERVICE_URL'])
  end
end
