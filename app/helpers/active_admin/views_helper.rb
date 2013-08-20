module ActiveAdmin
  module ViewsHelper
    def collection_for_hour_select
      (0..48).map do |i|
        [
          (Time.now.at_beginning_of_day + (i.to_f/2).hours).strftime('%l:%M%P'),
          (i.to_f / 2)
        ]
      end
    end
  end
end
