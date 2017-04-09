class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Stocks API'
      key :description, 'The Stocks API documentation, that shows how to create an account,' \
                        'login and create and receive stock price alerts.'
      key :termsOfService, ''
      contact do
        key :name, 'Marhic Jérôme'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'user'
      key :description, 'User operations'
      externalDocs do
        key :description, 'Find more info here'
        key :url, 'https://stocks.bandanatech.org'
      end
    end
    tag do
      key :name, 'alert'
      key :description, 'Alert operations'
    end
    key :host, ENV['BASE_URL']
    key :basePath, '/api'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Api::UsersController,
    Api::AlertsController,
    Api::ApiApplicationController,
    Api::StocksController,
    Alert,
    Stocks,
    StocksController,
    User,
    ErrorModel,
    self
  ].freeze

  def index
    respond_to do |format|
      format.json { render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES) }
      format.html
    end
  end
end
