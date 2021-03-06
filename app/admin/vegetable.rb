ActiveAdmin.register Vegetable do
  menu parent: :other, priority: 10
  actions :all, except: [:show]

  index do
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.inputs do
      translated_input(f, :names)
      f.actions
    end
  end

  permit_params(names: I18n.available_locales)

  config.filters = false
  config.per_page = 50
  config.sort_order = -> { "names->>'#{I18n.locale}'" }
end
