module Traktion
  class Control
    def shows
      @shows ||= Traktion::Models::Show
    end
  end

  module Models
    class Show < Base
      custom_get :popular, :trending

      def self.updates(date)
        get("shows/updates/#{date}")
      end

      # Create accessor methods for the nested resources.
      ['aliases', 'comments', 'people', 'ratings', 'translations'].each do |path|
        define_method(path.to_s) do |argument = ''|
          raw_resource(path.to_s, argument)
        end
      end

      private

      def slug
        self.ids['slug']
      end

      def raw_resource(name, parameter = '')
        Show.get_raw("shows/#{slug}/#{name}/#{parameter}") {|parsed_response| parsed_response[:data]}
      end
    end
  end
end
