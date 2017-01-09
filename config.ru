require "./config/environment"
# require "./app/"

use Rack::MethodOverride
use CarController
use CarSerializer
run ApplicationController