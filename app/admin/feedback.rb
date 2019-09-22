ActiveAdmin.register Feedback do
  menu parent: "Sessions", priority: 1

  config.sort_order = "created_at_desc"

  index do
    selectable_column
    column :created_at
    column :submission
    column :comments
    column(:rating) do |f|
      status_tag f.human_rating, class: status_for_rating(f.rating)
    end
    actions
  end

  config.filters = false
end
