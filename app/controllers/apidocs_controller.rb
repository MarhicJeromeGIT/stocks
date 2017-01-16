class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Stocks API'
      key :description, 'The Stocks API documentation, that shows how to create an account' \
                        'and create and receive stock price alerts'
      key :termsOfService, ''
      contact do
        key :name, 'www.bandanatech.org'
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
    key :host, '52.211.249.61:3000'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Api::UsersController,
    User,
    ErrorModel,
    self
  ].freeze

  def index
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS , PUT'
    response.headers['Access-Control-Allow-Origin'] =  '*'

    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
