module Traktion
  class Client
    def shows
      @shows ||= Traktion::Models::Show
    end
  end

  module Models
    class Show < Traktion::Models::Base
      custom_get :popular, :trending

      def self.updates(date)
        get("/shows/updates/#{date}")
      end

      def aliases
        @aliases ||= Traktion::Models::Alias
        @aliases.all(_show_id: slug)
      end

      def translations(lang = :all)
        @translations ||= Traktion::Models::Translation

        if lang == :all
          @translations.all(_show_id: slug)
        else
          @translations.find(lang, _show_id: slug)
        end
      end

      private

      def slug
        self.ids[:slug]
      end
    end

    class Alias < Traktion::Models::Base
      collection_path "shows/:show_id/aliases"
    end

    class Translation < Traktion::Models::Base
      collection_path "shows/:show_id/translations"
    end
  end
end
