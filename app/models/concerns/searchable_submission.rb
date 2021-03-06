module SearchableSubmission
  extend ActiveSupport::Concern

  class_methods do
    def searchable_language
      "english"
    end

    def fulltext_search(terms)
      if terms.present?
        predicate = {
          title: terms,
          description: terms,
          users: {name: terms},
          companies: {name: terms},
          venues: {name: terms},
        }
        joins(:submitter)
          .left_outer_joins(:company, :venue)
          .basic_search(predicate, false)
      else
        all
      end
    end
  end
end
