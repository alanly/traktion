module Traktion
  module Models
    class Base
      include Her::Model
      uses_api Traktion.api
    end
  end
end
